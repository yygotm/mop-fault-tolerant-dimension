import MopFTMD.Data

set_option maxRecDepth 100000
set_option maxHeartbeats 0

namespace MopFTMD

theorem one_checked : Data.e7_000.check := by decide +kernel

theorem one_sound : Data.e7_000.result := Data.e7_000.sound one_checked

#print axioms one_checked
#print axioms one_sound

end MopFTMD
