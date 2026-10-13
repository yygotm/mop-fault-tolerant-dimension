import MopFTMD.Distance

namespace MopFTMD

/-- Concrete binary decomposition data, with an ordered root edge. -/
inductive TriangulationTree where
  | edge
  | join (left right : TriangulationTree)
  deriving DecidableEq, Repr

def TriangulationTree.order : TriangulationTree → ℕ
  | .edge => 2
  | .join l r => l.order + r.order - 1

def TriangulationTree.edges : TriangulationTree → List (ℕ × ℕ)
  | .edge => [(0, 1)]
  | .join l r =>
    l.edges ++ r.edges.map (fun (a, b) => (a + l.order - 1, b + l.order - 1)) ++
      [(0, l.order + r.order - 2)]

def TriangulationTree.graph (t : TriangulationTree) (n : ℕ) : SimpleGraph (Fin n) where
  Adj u v := u ≠ v ∧ ((u.val, v.val) ∈ t.edges ∨ (v.val, u.val) ∈ t.edges)
  symm := ⟨by intro u v h; exact ⟨Ne.symm h.1, h.2.symm⟩⟩
  loopless := ⟨by intro u h; exact h.1 rfl⟩

instance (t : TriangulationTree) (n : ℕ) : DecidableRel (t.graph n).Adj :=
  fun _ _ => inferInstanceAs (Decidable (_ ∧ (_ ∨ _)))

def TableFTRS {n : ℕ} (D : Fin n → Fin n → ℕ) (W : Finset (Fin n)) : Prop :=
  ∀ u v, u ≠ v →
    2 ≤ (W.filter (fun w => D w u ≠ D w v)).card

instance {n : ℕ} (D : Fin n → Fin n → ℕ) (W : Finset (Fin n)) :
    Decidable (TableFTRS D W) := inferInstanceAs
      (Decidable (∀ u v, u ≠ v → 2 ≤ (W.filter (fun w => D w u ≠ D w v)).card))

instance {n : ℕ} (t : TriangulationTree) (D : Fin n → Fin n → ℕ) :
    Decidable (DistanceCertificate (t.graph n) D) :=
  inferInstanceAs (Decidable (_ ∧ _ ∧ _ ∧ _))

/-- This is a decidable mathematical predicate, not a trusted executable claim. -/
def ExampleCheck {n : ℕ} (t : TriangulationTree) (D : Fin n → Fin n → ℕ)
    (W : Finset (Fin n)) : Prop :=
  t.order = n ∧ DistanceCertificate (t.graph n) D ∧
    W.card ≤ (n + 1) / 2 ∧ TableFTRS D W

instance {n : ℕ} (t : TriangulationTree) (D : Fin n → Fin n → ℕ)
    (W : Finset (Fin n)) : Decidable (ExampleCheck t D W) :=
  inferInstanceAs (Decidable (_ ∧ _ ∧ _ ∧ _))

theorem tableFTRS_sound {n : ℕ} (t : TriangulationTree)
    (D : Fin n → Fin n → ℕ) (W : Finset (Fin n))
    (hd : DistanceCertificate (t.graph n) D) (hw : TableFTRS D W) :
    FaultTolerantResolving (t.graph n) W := by
  intro u v huv
  have hcard : 1 < (W.filter (fun w => D w u ≠ D w v)).card := hw u v huv
  obtain ⟨s, hs, q, hq, hsq⟩ := Finset.one_lt_card.mp hcard
  obtain ⟨hs, hsu⟩ := Finset.mem_filter.mp hs
  obtain ⟨hq, hqu⟩ := Finset.mem_filter.mp hq
  refine ⟨s, hs, q, hq, hsq, ?_, ?_⟩
  · simpa only [distanceCertificate_eq_dist (t.graph n) D hd] using hsu
  · simpa only [distanceCertificate_eq_dist (t.graph n) D hd] using hqu

theorem exampleCheck_sound {n : ℕ} (t : TriangulationTree)
    (D : Fin n → Fin n → ℕ) (W : Finset (Fin n)) (h : ExampleCheck t D W) :
    FaultTolerantResolving (t.graph n) W ∧ W.card ≤ (n + 1) / 2 ∧
      faultTolerantMetricDimension (t.graph n) ≤ (n + 1) / 2 := by
  have hw := tableFTRS_sound t D W h.2.1 h.2.2.2
  exact ⟨hw, h.2.2.1, (dimension_le_card _ hw).trans h.2.2.1⟩

structure Example (n : ℕ) where
  tree : TriangulationTree
  table : Array (Array ℕ)
  selected : Finset (Fin n)

def Example.distance {n : ℕ} (e : Example n) (u v : Fin n) : ℕ :=
  e.table[u.val]![v.val]!

def Example.check {n : ℕ} (e : Example n) : Prop :=
  ExampleCheck e.tree e.distance e.selected

instance {n : ℕ} (e : Example n) : Decidable e.check :=
  inferInstanceAs (Decidable (ExampleCheck _ _ _))

def Example.result {n : ℕ} (e : Example n) : Prop :=
  FaultTolerantResolving (e.tree.graph n) e.selected ∧
  e.selected.card ≤ (n + 1) / 2 ∧
  faultTolerantMetricDimension (e.tree.graph n) ≤ (n + 1) / 2

theorem Example.sound {n : ℕ} (e : Example n) (h : e.check) : e.result :=
  exampleCheck_sound e.tree e.distance e.selected h

end MopFTMD
