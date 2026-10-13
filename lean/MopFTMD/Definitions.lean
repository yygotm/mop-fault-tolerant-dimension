import Mathlib.Combinatorics.SimpleGraph.Metric
import Mathlib.Data.Nat.Find
import Lean.Elab.Tactic.Omega

namespace MopFTMD

variable {V : Type*} [DecidableEq V] (G : SimpleGraph V)

def Resolving (W : Finset V) : Prop :=
  ∀ u v, u ≠ v → ∃ w ∈ W, G.dist w u ≠ G.dist w v

def FaultTolerantResolving (W : Finset V) : Prop :=
  ∀ u v, u ≠ v → ∃ s ∈ W, ∃ t ∈ W,
    s ≠ t ∧ G.dist s u ≠ G.dist s v ∧ G.dist t u ≠ G.dist t v

def DeletionResolving (W : Finset V) : Prop :=
  Resolving G W ∧ ∀ w ∈ W, Resolving G (W.erase w)

theorem faultTolerantResolving_iff_deletion (W : Finset V) :
    FaultTolerantResolving G W ↔ DeletionResolving G W := by
  constructor
  · intro h
    constructor
    · intro u v huv
      obtain ⟨s, hs, t, ht, _, hsu, _⟩ := h u v huv
      exact ⟨s, hs, hsu⟩
    · intro w hw u v huv
      obtain ⟨s, hs, t, ht, hst, hsu, htu⟩ := h u v huv
      by_cases hsw : s = w
      · subst s
        exact ⟨t, Finset.mem_erase.mpr ⟨Ne.symm hst, ht⟩, htu⟩
      · exact ⟨s, Finset.mem_erase.mpr ⟨hsw, hs⟩, hsu⟩
  · rintro ⟨h, hd⟩ u v huv
    obtain ⟨s, hs, hsu⟩ := h u v huv
    obtain ⟨t, ht, htu⟩ := hd s hs u v huv
    obtain ⟨hts, ht⟩ := Finset.mem_erase.mp ht
    exact ⟨s, hs, t, ht, Ne.symm hts, hsu, htu⟩

noncomputable def faultTolerantMetricDimension : ℕ :=
  sInf {k : ℕ | ∃ W : Finset V, FaultTolerantResolving G W ∧ W.card = k}

omit [DecidableEq V] in
theorem dimension_le_card {W : Finset V} (h : FaultTolerantResolving G W) :
    faultTolerantMetricDimension G ≤ W.card :=
  Nat.sInf_le ⟨W, h, rfl⟩

omit [DecidableEq V] in
theorem univ_faultTolerantResolving [Fintype V] (hconn : G.Connected) :
    FaultTolerantResolving G Finset.univ := by
  intro u v huv
  refine ⟨u, Finset.mem_univ _, v, Finset.mem_univ _, huv, ?_, ?_⟩
  · simpa only [SimpleGraph.dist_self] using
      Nat.ne_of_lt (hconn.pos_dist_of_ne huv)
  · simpa only [SimpleGraph.dist_self] using
      (Nat.ne_of_lt (hconn.pos_dist_of_ne (Ne.symm huv))).symm

omit [DecidableEq V] in
theorem dimension_attained [Fintype V] (hconn : G.Connected) :
    ∃ W : Finset V, FaultTolerantResolving G W ∧
      W.card = faultTolerantMetricDimension G := by
  have hn : {k : ℕ | ∃ W : Finset V,
      FaultTolerantResolving G W ∧ W.card = k}.Nonempty :=
    ⟨Fintype.card V, Finset.univ, univ_faultTolerantResolving G hconn,
      Finset.card_univ⟩
  exact Nat.sInf_mem hn

end MopFTMD
