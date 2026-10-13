import MopFTMD.Data

set_option maxRecDepth 100000
set_option maxHeartbeats 0

namespace MopFTMD

def removedLandmark : Example 7 :=
  { Data.e7_000 with selected := Data.e7_000.selected.erase 0 }

def brokenDistance (u v : Fin 7) : ℕ :=
  if u = 0 ∧ v = 1 then Data.e7_000.distance u v + 1
  else Data.e7_000.distance u v

theorem removedLandmark_size :
    removedLandmark.selected.card + 1 = Data.e7_000.selected.card := by decide +kernel

theorem removedLandmark_rejected : decide removedLandmark.check = false := by decide +kernel

theorem removedLandmark_twoWitness_rejected :
    decide (TableFTRS Data.e7_000.distance removedLandmark.selected) = false := by
  decide +kernel

theorem brokenDistance_rejected :
    decide (DistanceCertificate (Data.e7_000.tree.graph 7) brokenDistance) = false := by
  decide +kernel

theorem brokenDistance_single_entry :
    ∀ u v : Fin 7, brokenDistance u v ≠ Data.e7_000.distance u v ↔ u = 0 ∧ v = 1 := by
  decide +kernel

#print axioms removedLandmark_size
#print axioms removedLandmark_rejected
#print axioms removedLandmark_twoWitness_rejected
#print axioms brokenDistance_rejected
#print axioms brokenDistance_single_entry

end MopFTMD
