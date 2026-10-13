import MopFTMD.Data

set_option maxRecDepth 100000
set_option maxHeartbeats 0

namespace MopFTMD
open Data

theorem checked_e7_000 : e7_000.check := by decide +kernel

theorem checked_e7_001 : e7_001.check := by decide +kernel

theorem checked_e7_002 : e7_002.check := by decide +kernel

theorem checked_e7_003 : e7_003.check := by decide +kernel

theorem checked_e7_004 : e7_004.check := by decide +kernel

theorem checked_e7_005 : e7_005.check := by decide +kernel

theorem checked_e7_006 : e7_006.check := by decide +kernel

theorem checked_e7_007 : e7_007.check := by decide +kernel

theorem checked_e7_008 : e7_008.check := by decide +kernel

theorem checked_e7_009 : e7_009.check := by decide +kernel

theorem checked_e7_010 : e7_010.check := by decide +kernel

theorem checked_e7_011 : e7_011.check := by decide +kernel

theorem checked_e7_012 : e7_012.check := by decide +kernel

theorem checked_e7_013 : e7_013.check := by decide +kernel

theorem checked_e7_014 : e7_014.check := by decide +kernel

theorem checked_e7_015 : e7_015.check := by decide +kernel

theorem checked_e7_016 : e7_016.check := by decide +kernel

theorem checked_e7_017 : e7_017.check := by decide +kernel

theorem checked_e7_018 : e7_018.check := by decide +kernel

theorem checked_e7_019 : e7_019.check := by decide +kernel

theorem checked_e7_020 : e7_020.check := by decide +kernel

theorem checked_e7_021 : e7_021.check := by decide +kernel

theorem checked_e7_022 : e7_022.check := by decide +kernel

theorem checked_e7_023 : e7_023.check := by decide +kernel

theorem checked_e7_024 : e7_024.check := by decide +kernel

theorem checked_e7_025 : e7_025.check := by decide +kernel

theorem checked_e7_026 : e7_026.check := by decide +kernel

theorem checked_e7_027 : e7_027.check := by decide +kernel

theorem checked_e7_028 : e7_028.check := by decide +kernel

theorem checked_e7_029 : e7_029.check := by decide +kernel

theorem checked_e7_030 : e7_030.check := by decide +kernel

theorem checked_e7_031 : e7_031.check := by decide +kernel

theorem checked_e7_032 : e7_032.check := by decide +kernel

theorem checked_e7_033 : e7_033.check := by decide +kernel

theorem checked_e7_034 : e7_034.check := by decide +kernel

theorem checked_e7_035 : e7_035.check := by decide +kernel

theorem checked_e7_036 : e7_036.check := by decide +kernel

theorem checked_e7_037 : e7_037.check := by decide +kernel

theorem checked_e7_038 : e7_038.check := by decide +kernel

theorem checked_e7_039 : e7_039.check := by decide +kernel

theorem checked_e7_040 : e7_040.check := by decide +kernel

theorem checked_e7_041 : e7_041.check := by decide +kernel

theorem cases7_checked : cases7.Forall Example.check :=
  ((List.forall_cons _ _ _).mpr ⟨checked_e7_000, ((List.forall_cons _ _ _).mpr ⟨checked_e7_001, ((List.forall_cons _ _ _).mpr ⟨checked_e7_002, ((List.forall_cons _ _ _).mpr ⟨checked_e7_003, ((List.forall_cons _ _ _).mpr ⟨checked_e7_004, ((List.forall_cons _ _ _).mpr ⟨checked_e7_005, ((List.forall_cons _ _ _).mpr ⟨checked_e7_006, ((List.forall_cons _ _ _).mpr ⟨checked_e7_007, ((List.forall_cons _ _ _).mpr ⟨checked_e7_008, ((List.forall_cons _ _ _).mpr ⟨checked_e7_009, ((List.forall_cons _ _ _).mpr ⟨checked_e7_010, ((List.forall_cons _ _ _).mpr ⟨checked_e7_011, ((List.forall_cons _ _ _).mpr ⟨checked_e7_012, ((List.forall_cons _ _ _).mpr ⟨checked_e7_013, ((List.forall_cons _ _ _).mpr ⟨checked_e7_014, ((List.forall_cons _ _ _).mpr ⟨checked_e7_015, ((List.forall_cons _ _ _).mpr ⟨checked_e7_016, ((List.forall_cons _ _ _).mpr ⟨checked_e7_017, ((List.forall_cons _ _ _).mpr ⟨checked_e7_018, ((List.forall_cons _ _ _).mpr ⟨checked_e7_019, ((List.forall_cons _ _ _).mpr ⟨checked_e7_020, ((List.forall_cons _ _ _).mpr ⟨checked_e7_021, ((List.forall_cons _ _ _).mpr ⟨checked_e7_022, ((List.forall_cons _ _ _).mpr ⟨checked_e7_023, ((List.forall_cons _ _ _).mpr ⟨checked_e7_024, ((List.forall_cons _ _ _).mpr ⟨checked_e7_025, ((List.forall_cons _ _ _).mpr ⟨checked_e7_026, ((List.forall_cons _ _ _).mpr ⟨checked_e7_027, ((List.forall_cons _ _ _).mpr ⟨checked_e7_028, ((List.forall_cons _ _ _).mpr ⟨checked_e7_029, ((List.forall_cons _ _ _).mpr ⟨checked_e7_030, ((List.forall_cons _ _ _).mpr ⟨checked_e7_031, ((List.forall_cons _ _ _).mpr ⟨checked_e7_032, ((List.forall_cons _ _ _).mpr ⟨checked_e7_033, ((List.forall_cons _ _ _).mpr ⟨checked_e7_034, ((List.forall_cons _ _ _).mpr ⟨checked_e7_035, ((List.forall_cons _ _ _).mpr ⟨checked_e7_036, ((List.forall_cons _ _ _).mpr ⟨checked_e7_037, ((List.forall_cons _ _ _).mpr ⟨checked_e7_038, ((List.forall_cons _ _ _).mpr ⟨checked_e7_039, ((List.forall_cons _ _ _).mpr ⟨checked_e7_040, ((List.forall_cons _ _ _).mpr ⟨checked_e7_041, True.intro⟩)⟩)⟩)⟩)⟩)⟩)⟩)⟩)⟩)⟩)⟩)⟩)⟩)⟩)⟩)⟩)⟩)⟩)⟩)⟩)⟩)⟩)⟩)⟩)⟩)⟩)⟩)⟩)⟩)⟩)⟩)⟩)⟩)⟩)⟩)⟩)⟩)⟩)⟩)⟩)⟩)⟩)

theorem cases7_sound : ∀ e ∈ cases7, e.result := by
  intro e he
  exact e.sound ((List.forall_iff_forall_mem.mp cases7_checked) e he)

theorem cases7_count : cases7.length = 42 := by decide +kernel

#print axioms cases7_checked
#print axioms cases7_sound
#print axioms cases7_count

end MopFTMD
