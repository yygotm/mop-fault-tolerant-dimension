import MopFTMD.Definitions

namespace MopFTMD

variable {V : Type*} [Fintype V] [DecidableEq V]
variable (G : SimpleGraph V) [DecidableRel G.Adj]

/-- Executable finite search for a walk of length at most k. -/
def within : ℕ → V → V → Bool
  | 0, u, v => decide (u = v)
  | k + 1, u, v => within k u v ||
      decide (∃ w, G.Adj u w ∧ within k w v = true)

theorem within_iff (k : ℕ) (u v : V) :
    within G k u v = true ↔ ∃ p : G.Walk u v, p.length ≤ k := by
  induction k generalizing u with
  | zero =>
    simp only [within, decide_eq_true_eq, Nat.le_zero]
    exact SimpleGraph.Walk.exists_length_eq_zero_iff.symm
  | succ k ih =>
    simp only [within, Bool.or_eq_true, decide_eq_true_eq, ih]
    constructor
    · rintro (⟨p, hp⟩ | ⟨w, huw, p, hp⟩)
      · exact ⟨p, by omega⟩
      · exact ⟨p.cons huw, by simpa using Nat.succ_le_succ hp⟩
    · rintro ⟨p, hp⟩
      cases p with
      | nil => exact Or.inl ⟨.nil, Nat.zero_le _⟩
      | cons huw p =>
        exact Or.inr ⟨_, huw, p, by simpa using hp⟩

theorem exists_within (hconn : G.Connected) (u v : V) :
    ∃ k, within G k u v = true := by
  obtain ⟨p⟩ := hconn u v
  exact ⟨p.length, (within_iff G _ _ _).mpr ⟨p, le_rfl⟩⟩

/-- Computable on connected finite graphs: search for the first reachable layer.
The connectedness proof guarantees termination and is erased at runtime. -/
def computableDist (hconn : G.Connected) (u v : V) : ℕ :=
  Nat.find (exists_within G hconn u v)

theorem computableDist_eq_dist (hconn : G.Connected) (u v : V) :
    computableDist G hconn u v = G.dist u v := by
  apply Nat.le_antisymm
  · obtain ⟨p, hp⟩ := hconn.exists_walk_length_eq_dist u v
    apply Nat.find_min'
    exact (within_iff G _ _ _).mpr ⟨p, hp.le⟩
  · obtain ⟨p, hp⟩ := (within_iff G _ _ _).mp
      (Nat.find_spec (exists_within G hconn u v))
    exact (SimpleGraph.dist_le p).trans hp

/-- Local conditions which certify an explicitly supplied distance table. -/
def DistanceCertificate (D : V → V → ℕ) : Prop :=
  (∀ u, D u u = 0) ∧
  (∀ u v, u ≠ v → 0 < D u v) ∧
  (∀ u w, G.Adj u w → ∀ v, D u v ≤ D w v + 1) ∧
  (∀ u v, u ≠ v → ∃ w, G.Adj u w ∧ D u v = D w v + 1)

omit [Fintype V] [DecidableRel G.Adj] in
theorem certified_walk (D : V → V → ℕ) (h : DistanceCertificate G D)
    (u v : V) : ∃ p : G.Walk u v, p.length = D u v := by
  induction hn : D u v using Nat.strong_induction_on generalizing u with
  | h n ih =>
    by_cases huv : u = v
    · subst u
      refine ⟨.nil, ?_⟩
      have hz := h.1 v
      simp only [SimpleGraph.Walk.length_nil]
      omega
    · obtain ⟨w, huw, hd⟩ := h.2.2.2 u v huv
      obtain ⟨p, hp⟩ := ih (D w v) (by omega) w rfl
      refine ⟨p.cons huw, ?_⟩
      simp only [SimpleGraph.Walk.length_cons, hp]
      omega

omit [Fintype V] [DecidableEq V] [DecidableRel G.Adj] in
theorem certified_lower (D : V → V → ℕ) (h : DistanceCertificate G D)
    {u v : V} (p : G.Walk u v) : D u v ≤ p.length := by
  induction p with
  | nil => simp [h.1]
  | @cons u w v huw p ih =>
    exact (h.2.2.1 u w huw v).trans (Nat.add_le_add_right ih 1)

omit [Fintype V] [DecidableRel G.Adj] in
theorem distanceCertificate_eq_dist (D : V → V → ℕ)
    (h : DistanceCertificate G D) (u v : V) : D u v = G.dist u v := by
  obtain ⟨p, hp⟩ := certified_walk G D h u v
  obtain ⟨q, hq⟩ := p.reachable.exists_walk_length_eq_dist
  exact Nat.le_antisymm (hq ▸ certified_lower G D h q)
    (hp ▸ SimpleGraph.dist_le p)

omit [Fintype V] [DecidableRel G.Adj] in
theorem distanceCertificate_connected [Nonempty V] (D : V → V → ℕ)
    (h : DistanceCertificate G D) : G.Connected := by
  refine { preconnected := ?_, nonempty := inferInstance }
  intro u v
  obtain ⟨p, _⟩ := certified_walk G D h u v
  exact ⟨p⟩

theorem distanceCertificate_eq_computableDist [Nonempty V]
    (D : V → V → ℕ) (h : DistanceCertificate G D) (u v : V) :
    D u v = computableDist G (distanceCertificate_connected G D h) u v := by
  rw [computableDist_eq_dist, distanceCertificate_eq_dist G D h]

end MopFTMD
