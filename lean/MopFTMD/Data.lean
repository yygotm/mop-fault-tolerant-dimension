import MopFTMD.Checker

namespace MopFTMD.Data

def e7_000 : Example 7 where
  tree := (.join .edge (.join .edge (.join .edge (.join .edge (.join .edge .edge)))))
  table := #[#[0, 1, 2, 2, 2, 2, 1], #[1, 0, 1, 2, 2, 2, 1], #[2, 1, 0, 1, 2, 2, 1], #[2, 2, 1, 0, 1, 2, 1], #[2, 2, 2, 1, 0, 1, 1], #[2, 2, 2, 2, 1, 0, 1], #[1, 1, 1, 1, 1, 1, 0]]
  selected := {0, 2, 3, 5}

def e7_001 : Example 7 where
  tree := (.join .edge (.join .edge (.join .edge (.join (.join .edge .edge) .edge))))
  table := #[#[0, 1, 2, 2, 3, 2, 1], #[1, 0, 1, 2, 3, 2, 1], #[2, 1, 0, 1, 2, 2, 1], #[2, 2, 1, 0, 1, 1, 1], #[3, 3, 2, 1, 0, 1, 2], #[2, 2, 2, 1, 1, 0, 1], #[1, 1, 1, 1, 2, 1, 0]]
  selected := {0, 2, 3, 5}

def e7_002 : Example 7 where
  tree := (.join .edge (.join .edge (.join (.join .edge .edge) (.join .edge .edge))))
  table := #[#[0, 1, 2, 3, 2, 2, 1], #[1, 0, 1, 2, 2, 2, 1], #[2, 1, 0, 1, 1, 2, 1], #[3, 2, 1, 0, 1, 2, 2], #[2, 2, 1, 1, 0, 1, 1], #[2, 2, 2, 2, 1, 0, 1], #[1, 1, 1, 2, 1, 1, 0]]
  selected := {0, 2, 4, 5}

def e7_003 : Example 7 where
  tree := (.join .edge (.join .edge (.join (.join .edge (.join .edge .edge)) .edge)))
  table := #[#[0, 1, 2, 3, 3, 2, 1], #[1, 0, 1, 2, 3, 2, 1], #[2, 1, 0, 1, 2, 1, 1], #[3, 2, 1, 0, 1, 1, 2], #[3, 3, 2, 1, 0, 1, 2], #[2, 2, 1, 1, 1, 0, 1], #[1, 1, 1, 2, 2, 1, 0]]
  selected := {0, 2, 4, 5}

def e7_004 : Example 7 where
  tree := (.join .edge (.join .edge (.join (.join (.join .edge .edge) .edge) .edge)))
  table := #[#[0, 1, 2, 3, 3, 2, 1], #[1, 0, 1, 2, 2, 2, 1], #[2, 1, 0, 1, 1, 1, 1], #[3, 2, 1, 0, 1, 2, 2], #[3, 2, 1, 1, 0, 1, 2], #[2, 2, 1, 2, 1, 0, 1], #[1, 1, 1, 2, 2, 1, 0]]
  selected := {0, 1, 4, 5}

def e7_005 : Example 7 where
  tree := (.join .edge (.join (.join .edge .edge) (.join .edge (.join .edge .edge))))
  table := #[#[0, 1, 2, 2, 2, 2, 1], #[1, 0, 1, 1, 2, 2, 1], #[2, 1, 0, 1, 2, 3, 2], #[2, 1, 1, 0, 1, 2, 1], #[2, 2, 2, 1, 0, 1, 1], #[2, 2, 3, 2, 1, 0, 1], #[1, 1, 2, 1, 1, 1, 0]]
  selected := {0, 2, 4, 5}

def e7_006 : Example 7 where
  tree := (.join .edge (.join (.join .edge .edge) (.join (.join .edge .edge) .edge)))
  table := #[#[0, 1, 2, 2, 3, 2, 1], #[1, 0, 1, 1, 2, 2, 1], #[2, 1, 0, 1, 2, 2, 2], #[2, 1, 1, 0, 1, 1, 1], #[3, 2, 2, 1, 0, 1, 2], #[2, 2, 2, 1, 1, 0, 1], #[1, 1, 2, 1, 2, 1, 0]]
  selected := {0, 2, 4, 5}

def e7_007 : Example 7 where
  tree := (.join .edge (.join (.join .edge (.join .edge .edge)) (.join .edge .edge)))
  table := #[#[0, 1, 2, 3, 2, 2, 1], #[1, 0, 1, 2, 1, 2, 1], #[2, 1, 0, 1, 1, 2, 2], #[3, 2, 1, 0, 1, 2, 2], #[2, 1, 1, 1, 0, 1, 1], #[2, 2, 2, 2, 1, 0, 1], #[1, 1, 2, 2, 1, 1, 0]]
  selected := {0, 2, 3, 5}

def e7_008 : Example 7 where
  tree := (.join .edge (.join (.join (.join .edge .edge) .edge) (.join .edge .edge)))
  table := #[#[0, 1, 2, 2, 2, 2, 1], #[1, 0, 1, 1, 1, 2, 1], #[2, 1, 0, 1, 2, 3, 2], #[2, 1, 1, 0, 1, 2, 2], #[2, 1, 2, 1, 0, 1, 1], #[2, 2, 3, 2, 1, 0, 1], #[1, 1, 2, 2, 1, 1, 0]]
  selected := {0, 2, 4, 6}

def e7_009 : Example 7 where
  tree := (.join .edge (.join (.join .edge (.join .edge (.join .edge .edge))) .edge))
  table := #[#[0, 1, 2, 3, 3, 2, 1], #[1, 0, 1, 2, 2, 1, 1], #[2, 1, 0, 1, 2, 1, 2], #[3, 2, 1, 0, 1, 1, 2], #[3, 2, 2, 1, 0, 1, 2], #[2, 1, 1, 1, 1, 0, 1], #[1, 1, 2, 2, 2, 1, 0]]
  selected := {0, 2, 4, 6}

def e7_010 : Example 7 where
  tree := (.join .edge (.join (.join .edge (.join (.join .edge .edge) .edge)) .edge))
  table := #[#[0, 1, 2, 3, 3, 2, 1], #[1, 0, 1, 2, 2, 1, 1], #[2, 1, 0, 1, 1, 1, 2], #[3, 2, 1, 0, 1, 2, 3], #[3, 2, 1, 1, 0, 1, 2], #[2, 1, 1, 2, 1, 0, 1], #[1, 1, 2, 3, 2, 1, 0]]
  selected := {0, 2, 4, 6}

def e7_011 : Example 7 where
  tree := (.join .edge (.join (.join (.join .edge .edge) (.join .edge .edge)) .edge))
  table := #[#[0, 1, 2, 2, 3, 2, 1], #[1, 0, 1, 1, 2, 1, 1], #[2, 1, 0, 1, 2, 2, 2], #[2, 1, 1, 0, 1, 1, 2], #[3, 2, 2, 1, 0, 1, 2], #[2, 1, 2, 1, 1, 0, 1], #[1, 1, 2, 2, 2, 1, 0]]
  selected := {0, 2, 4, 6}

def e7_012 : Example 7 where
  tree := (.join .edge (.join (.join (.join .edge (.join .edge .edge)) .edge) .edge))
  table := #[#[0, 1, 2, 3, 2, 2, 1], #[1, 0, 1, 2, 1, 1, 1], #[2, 1, 0, 1, 1, 2, 2], #[3, 2, 1, 0, 1, 2, 3], #[2, 1, 1, 1, 0, 1, 2], #[2, 1, 2, 2, 1, 0, 1], #[1, 1, 2, 3, 2, 1, 0]]
  selected := {0, 2, 4, 6}

def e7_013 : Example 7 where
  tree := (.join .edge (.join (.join (.join (.join .edge .edge) .edge) .edge) .edge))
  table := #[#[0, 1, 2, 2, 2, 2, 1], #[1, 0, 1, 1, 1, 1, 1], #[2, 1, 0, 1, 2, 2, 2], #[2, 1, 1, 0, 1, 2, 2], #[2, 1, 2, 1, 0, 1, 2], #[2, 1, 2, 2, 1, 0, 1], #[1, 1, 2, 2, 2, 1, 0]]
  selected := {0, 2, 4, 6}

def e7_014 : Example 7 where
  tree := (.join (.join .edge .edge) (.join .edge (.join .edge (.join .edge .edge))))
  table := #[#[0, 1, 1, 2, 2, 2, 1], #[1, 0, 1, 2, 3, 3, 2], #[1, 1, 0, 1, 2, 2, 1], #[2, 2, 1, 0, 1, 2, 1], #[2, 3, 2, 1, 0, 1, 1], #[2, 3, 2, 2, 1, 0, 1], #[1, 2, 1, 1, 1, 1, 0]]
  selected := {0, 1, 3, 5}

def e7_015 : Example 7 where
  tree := (.join (.join .edge .edge) (.join .edge (.join (.join .edge .edge) .edge)))
  table := #[#[0, 1, 1, 2, 3, 2, 1], #[1, 0, 1, 2, 3, 3, 2], #[1, 1, 0, 1, 2, 2, 1], #[2, 2, 1, 0, 1, 1, 1], #[3, 3, 2, 1, 0, 1, 2], #[2, 3, 2, 1, 1, 0, 1], #[1, 2, 1, 1, 2, 1, 0]]
  selected := {0, 1, 3, 5}

def e7_016 : Example 7 where
  tree := (.join (.join .edge .edge) (.join (.join .edge .edge) (.join .edge .edge)))
  table := #[#[0, 1, 1, 2, 2, 2, 1], #[1, 0, 1, 2, 2, 3, 2], #[1, 1, 0, 1, 1, 2, 1], #[2, 2, 1, 0, 1, 2, 2], #[2, 2, 1, 1, 0, 1, 1], #[2, 3, 2, 2, 1, 0, 1], #[1, 2, 1, 2, 1, 1, 0]]
  selected := {0, 1, 3, 5}

def e7_017 : Example 7 where
  tree := (.join (.join .edge .edge) (.join (.join .edge (.join .edge .edge)) .edge))
  table := #[#[0, 1, 1, 2, 3, 2, 1], #[1, 0, 1, 2, 3, 2, 2], #[1, 1, 0, 1, 2, 1, 1], #[2, 2, 1, 0, 1, 1, 2], #[3, 3, 2, 1, 0, 1, 2], #[2, 2, 1, 1, 1, 0, 1], #[1, 2, 1, 2, 2, 1, 0]]
  selected := {0, 1, 3, 5}

def e7_018 : Example 7 where
  tree := (.join (.join .edge .edge) (.join (.join (.join .edge .edge) .edge) .edge))
  table := #[#[0, 1, 1, 2, 2, 2, 1], #[1, 0, 1, 2, 2, 2, 2], #[1, 1, 0, 1, 1, 1, 1], #[2, 2, 1, 0, 1, 2, 2], #[2, 2, 1, 1, 0, 1, 2], #[2, 2, 1, 2, 1, 0, 1], #[1, 2, 1, 2, 2, 1, 0]]
  selected := {0, 1, 3, 5}

def e7_019 : Example 7 where
  tree := (.join (.join .edge (.join .edge .edge)) (.join .edge (.join .edge .edge)))
  table := #[#[0, 1, 2, 1, 2, 2, 1], #[1, 0, 1, 1, 2, 3, 2], #[2, 1, 0, 1, 2, 3, 2], #[1, 1, 1, 0, 1, 2, 1], #[2, 2, 2, 1, 0, 1, 1], #[2, 3, 3, 2, 1, 0, 1], #[1, 2, 2, 1, 1, 1, 0]]
  selected := {1, 2, 4, 6}

def e7_020 : Example 7 where
  tree := (.join (.join .edge (.join .edge .edge)) (.join (.join .edge .edge) .edge))
  table := #[#[0, 1, 2, 1, 2, 2, 1], #[1, 0, 1, 1, 2, 2, 2], #[2, 1, 0, 1, 2, 2, 2], #[1, 1, 1, 0, 1, 1, 1], #[2, 2, 2, 1, 0, 1, 2], #[2, 2, 2, 1, 1, 0, 1], #[1, 2, 2, 1, 2, 1, 0]]
  selected := {1, 2, 4, 6}

def e7_021 : Example 7 where
  tree := (.join (.join (.join .edge .edge) .edge) (.join .edge (.join .edge .edge)))
  table := #[#[0, 1, 1, 1, 2, 2, 1], #[1, 0, 1, 2, 3, 3, 2], #[1, 1, 0, 1, 2, 3, 2], #[1, 2, 1, 0, 1, 2, 1], #[2, 3, 2, 1, 0, 1, 1], #[2, 3, 3, 2, 1, 0, 1], #[1, 2, 2, 1, 1, 1, 0]]
  selected := {1, 3, 5, 6}

def e7_022 : Example 7 where
  tree := (.join (.join (.join .edge .edge) .edge) (.join (.join .edge .edge) .edge))
  table := #[#[0, 1, 1, 1, 2, 2, 1], #[1, 0, 1, 2, 3, 3, 2], #[1, 1, 0, 1, 2, 2, 2], #[1, 2, 1, 0, 1, 1, 1], #[2, 3, 2, 1, 0, 1, 2], #[2, 3, 2, 1, 1, 0, 1], #[1, 2, 2, 1, 2, 1, 0]]
  selected := {1, 2, 5, 6}

def e7_023 : Example 7 where
  tree := (.join (.join .edge (.join .edge (.join .edge .edge))) (.join .edge .edge))
  table := #[#[0, 1, 2, 2, 1, 2, 1], #[1, 0, 1, 2, 1, 2, 2], #[2, 1, 0, 1, 1, 2, 2], #[2, 2, 1, 0, 1, 2, 2], #[1, 1, 1, 1, 0, 1, 1], #[2, 2, 2, 2, 1, 0, 1], #[1, 2, 2, 2, 1, 1, 0]]
  selected := {0, 2, 3, 5}

def e7_024 : Example 7 where
  tree := (.join (.join .edge (.join (.join .edge .edge) .edge)) (.join .edge .edge))
  table := #[#[0, 1, 2, 2, 1, 2, 1], #[1, 0, 1, 1, 1, 2, 2], #[2, 1, 0, 1, 2, 3, 3], #[2, 1, 1, 0, 1, 2, 2], #[1, 1, 2, 1, 0, 1, 1], #[2, 2, 3, 2, 1, 0, 1], #[1, 2, 3, 2, 1, 1, 0]]
  selected := {0, 2, 3, 6}

def e7_025 : Example 7 where
  tree := (.join (.join (.join .edge .edge) (.join .edge .edge)) (.join .edge .edge))
  table := #[#[0, 1, 1, 2, 1, 2, 1], #[1, 0, 1, 2, 2, 3, 2], #[1, 1, 0, 1, 1, 2, 2], #[2, 2, 1, 0, 1, 2, 2], #[1, 2, 1, 1, 0, 1, 1], #[2, 3, 2, 2, 1, 0, 1], #[1, 2, 2, 2, 1, 1, 0]]
  selected := {1, 3, 5, 6}

def e7_026 : Example 7 where
  tree := (.join (.join (.join .edge (.join .edge .edge)) .edge) (.join .edge .edge))
  table := #[#[0, 1, 2, 1, 1, 2, 1], #[1, 0, 1, 1, 2, 3, 2], #[2, 1, 0, 1, 2, 3, 3], #[1, 1, 1, 0, 1, 2, 2], #[1, 2, 2, 1, 0, 1, 1], #[2, 3, 3, 2, 1, 0, 1], #[1, 2, 3, 2, 1, 1, 0]]
  selected := {1, 2, 4, 6}

def e7_027 : Example 7 where
  tree := (.join (.join (.join (.join .edge .edge) .edge) .edge) (.join .edge .edge))
  table := #[#[0, 1, 1, 1, 1, 2, 1], #[1, 0, 1, 2, 2, 3, 2], #[1, 1, 0, 1, 2, 3, 2], #[1, 2, 1, 0, 1, 2, 2], #[1, 2, 2, 1, 0, 1, 1], #[2, 3, 3, 2, 1, 0, 1], #[1, 2, 2, 2, 1, 1, 0]]
  selected := {1, 3, 4, 6}

def e7_028 : Example 7 where
  tree := (.join (.join .edge (.join .edge (.join .edge (.join .edge .edge)))) .edge)
  table := #[#[0, 1, 2, 2, 2, 1, 1], #[1, 0, 1, 2, 2, 1, 2], #[2, 1, 0, 1, 2, 1, 2], #[2, 2, 1, 0, 1, 1, 2], #[2, 2, 2, 1, 0, 1, 2], #[1, 1, 1, 1, 1, 0, 1], #[1, 2, 2, 2, 2, 1, 0]]
  selected := {1, 3, 4, 6}

def e7_029 : Example 7 where
  tree := (.join (.join .edge (.join .edge (.join (.join .edge .edge) .edge))) .edge)
  table := #[#[0, 1, 2, 3, 2, 1, 1], #[1, 0, 1, 2, 2, 1, 2], #[2, 1, 0, 1, 1, 1, 2], #[3, 2, 1, 0, 1, 2, 3], #[2, 2, 1, 1, 0, 1, 2], #[1, 1, 1, 2, 1, 0, 1], #[1, 2, 2, 3, 2, 1, 0]]
  selected := {0, 1, 3, 4}

def e7_030 : Example 7 where
  tree := (.join (.join .edge (.join (.join .edge .edge) (.join .edge .edge))) .edge)
  table := #[#[0, 1, 2, 2, 2, 1, 1], #[1, 0, 1, 1, 2, 1, 2], #[2, 1, 0, 1, 2, 2, 3], #[2, 1, 1, 0, 1, 1, 2], #[2, 2, 2, 1, 0, 1, 2], #[1, 1, 2, 1, 1, 0, 1], #[1, 2, 3, 2, 2, 1, 0]]
  selected := {0, 2, 4, 6}

def e7_031 : Example 7 where
  tree := (.join (.join .edge (.join (.join .edge (.join .edge .edge)) .edge)) .edge)
  table := #[#[0, 1, 2, 3, 2, 1, 1], #[1, 0, 1, 2, 1, 1, 2], #[2, 1, 0, 1, 1, 2, 3], #[3, 2, 1, 0, 1, 2, 3], #[2, 1, 1, 1, 0, 1, 2], #[1, 1, 2, 2, 1, 0, 1], #[1, 2, 3, 3, 2, 1, 0]]
  selected := {0, 2, 3, 5}

def e7_032 : Example 7 where
  tree := (.join (.join .edge (.join (.join (.join .edge .edge) .edge) .edge)) .edge)
  table := #[#[0, 1, 2, 2, 2, 1, 1], #[1, 0, 1, 1, 1, 1, 2], #[2, 1, 0, 1, 2, 2, 3], #[2, 1, 1, 0, 1, 2, 3], #[2, 1, 2, 1, 0, 1, 2], #[1, 1, 2, 2, 1, 0, 1], #[1, 2, 3, 3, 2, 1, 0]]
  selected := {0, 2, 4, 5}

def e7_033 : Example 7 where
  tree := (.join (.join (.join .edge .edge) (.join .edge (.join .edge .edge))) .edge)
  table := #[#[0, 1, 1, 2, 2, 1, 1], #[1, 0, 1, 2, 3, 2, 2], #[1, 1, 0, 1, 2, 1, 2], #[2, 2, 1, 0, 1, 1, 2], #[2, 3, 2, 1, 0, 1, 2], #[1, 2, 1, 1, 1, 0, 1], #[1, 2, 2, 2, 2, 1, 0]]
  selected := {1, 3, 4, 6}

def e7_034 : Example 7 where
  tree := (.join (.join (.join .edge .edge) (.join (.join .edge .edge) .edge)) .edge)
  table := #[#[0, 1, 1, 2, 2, 1, 1], #[1, 0, 1, 2, 2, 2, 2], #[1, 1, 0, 1, 1, 1, 2], #[2, 2, 1, 0, 1, 2, 3], #[2, 2, 1, 1, 0, 1, 2], #[1, 2, 1, 2, 1, 0, 1], #[1, 2, 2, 3, 2, 1, 0]]
  selected := {0, 1, 3, 5}

def e7_035 : Example 7 where
  tree := (.join (.join (.join .edge (.join .edge .edge)) (.join .edge .edge)) .edge)
  table := #[#[0, 1, 2, 1, 2, 1, 1], #[1, 0, 1, 1, 2, 2, 2], #[2, 1, 0, 1, 2, 2, 3], #[1, 1, 1, 0, 1, 1, 2], #[2, 2, 2, 1, 0, 1, 2], #[1, 2, 2, 1, 1, 0, 1], #[1, 2, 3, 2, 2, 1, 0]]
  selected := {1, 2, 4, 6}

def e7_036 : Example 7 where
  tree := (.join (.join (.join (.join .edge .edge) .edge) (.join .edge .edge)) .edge)
  table := #[#[0, 1, 1, 1, 2, 1, 1], #[1, 0, 1, 2, 3, 2, 2], #[1, 1, 0, 1, 2, 2, 2], #[1, 2, 1, 0, 1, 1, 2], #[2, 3, 2, 1, 0, 1, 2], #[1, 2, 2, 1, 1, 0, 1], #[1, 2, 2, 2, 2, 1, 0]]
  selected := {1, 3, 5, 6}

def e7_037 : Example 7 where
  tree := (.join (.join (.join .edge (.join .edge (.join .edge .edge))) .edge) .edge)
  table := #[#[0, 1, 2, 2, 1, 1, 1], #[1, 0, 1, 2, 1, 2, 2], #[2, 1, 0, 1, 1, 2, 3], #[2, 2, 1, 0, 1, 2, 3], #[1, 1, 1, 1, 0, 1, 2], #[1, 2, 2, 2, 1, 0, 1], #[1, 2, 3, 3, 2, 1, 0]]
  selected := {0, 2, 3, 5}

def e7_038 : Example 7 where
  tree := (.join (.join (.join .edge (.join (.join .edge .edge) .edge)) .edge) .edge)
  table := #[#[0, 1, 2, 2, 1, 1, 1], #[1, 0, 1, 1, 1, 2, 2], #[2, 1, 0, 1, 2, 3, 3], #[2, 1, 1, 0, 1, 2, 3], #[1, 1, 2, 1, 0, 1, 2], #[1, 2, 3, 2, 1, 0, 1], #[1, 2, 3, 3, 2, 1, 0]]
  selected := {0, 2, 4, 6}

def e7_039 : Example 7 where
  tree := (.join (.join (.join (.join .edge .edge) (.join .edge .edge)) .edge) .edge)
  table := #[#[0, 1, 1, 2, 1, 1, 1], #[1, 0, 1, 2, 2, 2, 2], #[1, 1, 0, 1, 1, 2, 2], #[2, 2, 1, 0, 1, 2, 3], #[1, 2, 1, 1, 0, 1, 2], #[1, 2, 2, 2, 1, 0, 1], #[1, 2, 2, 3, 2, 1, 0]]
  selected := {1, 3, 5, 6}

def e7_040 : Example 7 where
  tree := (.join (.join (.join (.join .edge (.join .edge .edge)) .edge) .edge) .edge)
  table := #[#[0, 1, 2, 1, 1, 1, 1], #[1, 0, 1, 1, 2, 2, 2], #[2, 1, 0, 1, 2, 3, 3], #[1, 1, 1, 0, 1, 2, 2], #[1, 2, 2, 1, 0, 1, 2], #[1, 2, 3, 2, 1, 0, 1], #[1, 2, 3, 2, 2, 1, 0]]
  selected := {1, 2, 4, 6}

def e7_041 : Example 7 where
  tree := (.join (.join (.join (.join (.join .edge .edge) .edge) .edge) .edge) .edge)
  table := #[#[0, 1, 1, 1, 1, 1, 1], #[1, 0, 1, 2, 2, 2, 2], #[1, 1, 0, 1, 2, 2, 2], #[1, 2, 1, 0, 1, 2, 2], #[1, 2, 2, 1, 0, 1, 2], #[1, 2, 2, 2, 1, 0, 1], #[1, 2, 2, 2, 2, 1, 0]]
  selected := {1, 3, 4, 6}

def cases7 : List (Example 7) := [
  e7_000,
  e7_001,
  e7_002,
  e7_003,
  e7_004,
  e7_005,
  e7_006,
  e7_007,
  e7_008,
  e7_009,
  e7_010,
  e7_011,
  e7_012,
  e7_013,
  e7_014,
  e7_015,
  e7_016,
  e7_017,
  e7_018,
  e7_019,
  e7_020,
  e7_021,
  e7_022,
  e7_023,
  e7_024,
  e7_025,
  e7_026,
  e7_027,
  e7_028,
  e7_029,
  e7_030,
  e7_031,
  e7_032,
  e7_033,
  e7_034,
  e7_035,
  e7_036,
  e7_037,
  e7_038,
  e7_039,
  e7_040,
  e7_041]

def e8_000 : Example 8 where
  tree := (.join .edge (.join .edge (.join .edge (.join .edge (.join .edge (.join .edge .edge))))))
  table := #[#[0, 1, 2, 2, 2, 2, 2, 1], #[1, 0, 1, 2, 2, 2, 2, 1], #[2, 1, 0, 1, 2, 2, 2, 1], #[2, 2, 1, 0, 1, 2, 2, 1], #[2, 2, 2, 1, 0, 1, 2, 1], #[2, 2, 2, 2, 1, 0, 1, 1], #[2, 2, 2, 2, 2, 1, 0, 1], #[1, 1, 1, 1, 1, 1, 1, 0]]
  selected := {0, 2, 4, 6}

def e8_001 : Example 8 where
  tree := (.join .edge (.join .edge (.join .edge (.join .edge (.join (.join .edge .edge) .edge)))))
  table := #[#[0, 1, 2, 2, 2, 3, 2, 1], #[1, 0, 1, 2, 2, 3, 2, 1], #[2, 1, 0, 1, 2, 3, 2, 1], #[2, 2, 1, 0, 1, 2, 2, 1], #[2, 2, 2, 1, 0, 1, 1, 1], #[3, 3, 3, 2, 1, 0, 1, 2], #[2, 2, 2, 2, 1, 1, 0, 1], #[1, 1, 1, 1, 1, 2, 1, 0]]
  selected := {0, 2, 4, 6}

def e8_002 : Example 8 where
  tree := (.join .edge (.join .edge (.join .edge (.join (.join .edge .edge) (.join .edge .edge)))))
  table := #[#[0, 1, 2, 2, 3, 2, 2, 1], #[1, 0, 1, 2, 3, 2, 2, 1], #[2, 1, 0, 1, 2, 2, 2, 1], #[2, 2, 1, 0, 1, 1, 2, 1], #[3, 3, 2, 1, 0, 1, 2, 2], #[2, 2, 2, 1, 1, 0, 1, 1], #[2, 2, 2, 2, 2, 1, 0, 1], #[1, 1, 1, 1, 2, 1, 1, 0]]
  selected := {0, 2, 5, 6}

def e8_003 : Example 8 where
  tree := (.join .edge (.join .edge (.join .edge (.join (.join .edge (.join .edge .edge)) .edge))))
  table := #[#[0, 1, 2, 2, 3, 3, 2, 1], #[1, 0, 1, 2, 3, 3, 2, 1], #[2, 1, 0, 1, 2, 3, 2, 1], #[2, 2, 1, 0, 1, 2, 1, 1], #[3, 3, 2, 1, 0, 1, 1, 2], #[3, 3, 3, 2, 1, 0, 1, 2], #[2, 2, 2, 1, 1, 1, 0, 1], #[1, 1, 1, 1, 2, 2, 1, 0]]
  selected := {0, 2, 4, 6}

def e8_004 : Example 8 where
  tree := (.join .edge (.join .edge (.join .edge (.join (.join (.join .edge .edge) .edge) .edge))))
  table := #[#[0, 1, 2, 2, 3, 3, 2, 1], #[1, 0, 1, 2, 3, 3, 2, 1], #[2, 1, 0, 1, 2, 2, 2, 1], #[2, 2, 1, 0, 1, 1, 1, 1], #[3, 3, 2, 1, 0, 1, 2, 2], #[3, 3, 2, 1, 1, 0, 1, 2], #[2, 2, 2, 1, 2, 1, 0, 1], #[1, 1, 1, 1, 2, 2, 1, 0]]
  selected := {0, 2, 4, 6}

def e8_005 : Example 8 where
  tree := (.join .edge (.join .edge (.join (.join .edge .edge) (.join .edge (.join .edge .edge)))))
  table := #[#[0, 1, 2, 3, 2, 2, 2, 1], #[1, 0, 1, 2, 2, 2, 2, 1], #[2, 1, 0, 1, 1, 2, 2, 1], #[3, 2, 1, 0, 1, 2, 3, 2], #[2, 2, 1, 1, 0, 1, 2, 1], #[2, 2, 2, 2, 1, 0, 1, 1], #[2, 2, 2, 3, 2, 1, 0, 1], #[1, 1, 1, 2, 1, 1, 1, 0]]
  selected := {0, 2, 5, 6}

def e8_006 : Example 8 where
  tree := (.join .edge (.join .edge (.join (.join .edge .edge) (.join (.join .edge .edge) .edge))))
  table := #[#[0, 1, 2, 3, 2, 3, 2, 1], #[1, 0, 1, 2, 2, 3, 2, 1], #[2, 1, 0, 1, 1, 2, 2, 1], #[3, 2, 1, 0, 1, 2, 2, 2], #[2, 2, 1, 1, 0, 1, 1, 1], #[3, 3, 2, 2, 1, 0, 1, 2], #[2, 2, 2, 2, 1, 1, 0, 1], #[1, 1, 1, 2, 1, 2, 1, 0]]
  selected := {0, 3, 5, 6}

def e8_007 : Example 8 where
  tree := (.join .edge (.join .edge (.join (.join .edge (.join .edge .edge)) (.join .edge .edge))))
  table := #[#[0, 1, 2, 3, 3, 2, 2, 1], #[1, 0, 1, 2, 3, 2, 2, 1], #[2, 1, 0, 1, 2, 1, 2, 1], #[3, 2, 1, 0, 1, 1, 2, 2], #[3, 3, 2, 1, 0, 1, 2, 2], #[2, 2, 1, 1, 1, 0, 1, 1], #[2, 2, 2, 2, 2, 1, 0, 1], #[1, 1, 1, 2, 2, 1, 1, 0]]
  selected := {0, 3, 4, 6}

def e8_008 : Example 8 where
  tree := (.join .edge (.join .edge (.join (.join (.join .edge .edge) .edge) (.join .edge .edge))))
  table := #[#[0, 1, 2, 3, 3, 2, 2, 1], #[1, 0, 1, 2, 2, 2, 2, 1], #[2, 1, 0, 1, 1, 1, 2, 1], #[3, 2, 1, 0, 1, 2, 3, 2], #[3, 2, 1, 1, 0, 1, 2, 2], #[2, 2, 1, 2, 1, 0, 1, 1], #[2, 2, 2, 3, 2, 1, 0, 1], #[1, 1, 1, 2, 2, 1, 1, 0]]
  selected := {0, 2, 5, 6}

def e8_009 : Example 8 where
  tree := (.join .edge (.join .edge (.join (.join .edge (.join .edge (.join .edge .edge))) .edge)))
  table := #[#[0, 1, 2, 3, 3, 3, 2, 1], #[1, 0, 1, 2, 3, 3, 2, 1], #[2, 1, 0, 1, 2, 2, 1, 1], #[3, 2, 1, 0, 1, 2, 1, 2], #[3, 3, 2, 1, 0, 1, 1, 2], #[3, 3, 2, 2, 1, 0, 1, 2], #[2, 2, 1, 1, 1, 1, 0, 1], #[1, 1, 1, 2, 2, 2, 1, 0]]
  selected := {1, 3, 4, 7}

def e8_010 : Example 8 where
  tree := (.join .edge (.join .edge (.join (.join .edge (.join (.join .edge .edge) .edge)) .edge)))
  table := #[#[0, 1, 2, 3, 4, 3, 2, 1], #[1, 0, 1, 2, 3, 3, 2, 1], #[2, 1, 0, 1, 2, 2, 1, 1], #[3, 2, 1, 0, 1, 1, 1, 2], #[4, 3, 2, 1, 0, 1, 2, 3], #[3, 3, 2, 1, 1, 0, 1, 2], #[2, 2, 1, 1, 2, 1, 0, 1], #[1, 1, 1, 2, 3, 2, 1, 0]]
  selected := {0, 3, 5, 6}

def e8_011 : Example 8 where
  tree := (.join .edge (.join .edge (.join (.join (.join .edge .edge) (.join .edge .edge)) .edge)))
  table := #[#[0, 1, 2, 3, 3, 3, 2, 1], #[1, 0, 1, 2, 2, 3, 2, 1], #[2, 1, 0, 1, 1, 2, 1, 1], #[3, 2, 1, 0, 1, 2, 2, 2], #[3, 2, 1, 1, 0, 1, 1, 2], #[3, 3, 2, 2, 1, 0, 1, 2], #[2, 2, 1, 2, 1, 1, 0, 1], #[1, 1, 1, 2, 2, 2, 1, 0]]
  selected := {0, 3, 5, 6}

def e8_012 : Example 8 where
  tree := (.join .edge (.join .edge (.join (.join (.join .edge (.join .edge .edge)) .edge) .edge)))
  table := #[#[0, 1, 2, 3, 4, 3, 2, 1], #[1, 0, 1, 2, 3, 2, 2, 1], #[2, 1, 0, 1, 2, 1, 1, 1], #[3, 2, 1, 0, 1, 1, 2, 2], #[4, 3, 2, 1, 0, 1, 2, 3], #[3, 2, 1, 1, 1, 0, 1, 2], #[2, 2, 1, 2, 2, 1, 0, 1], #[1, 1, 1, 2, 3, 2, 1, 0]]
  selected := {1, 3, 5, 6}

def e8_013 : Example 8 where
  tree := (.join .edge (.join .edge (.join (.join (.join (.join .edge .edge) .edge) .edge) .edge)))
  table := #[#[0, 1, 2, 3, 3, 3, 2, 1], #[1, 0, 1, 2, 2, 2, 2, 1], #[2, 1, 0, 1, 1, 1, 1, 1], #[3, 2, 1, 0, 1, 2, 2, 2], #[3, 2, 1, 1, 0, 1, 2, 2], #[3, 2, 1, 2, 1, 0, 1, 2], #[2, 2, 1, 2, 2, 1, 0, 1], #[1, 1, 1, 2, 2, 2, 1, 0]]
  selected := {1, 3, 5, 6}

def e8_014 : Example 8 where
  tree := (.join .edge (.join (.join .edge .edge) (.join .edge (.join .edge (.join .edge .edge)))))
  table := #[#[0, 1, 2, 2, 2, 2, 2, 1], #[1, 0, 1, 1, 2, 2, 2, 1], #[2, 1, 0, 1, 2, 3, 3, 2], #[2, 1, 1, 0, 1, 2, 2, 1], #[2, 2, 2, 1, 0, 1, 2, 1], #[2, 2, 3, 2, 1, 0, 1, 1], #[2, 2, 3, 2, 2, 1, 0, 1], #[1, 1, 2, 1, 1, 1, 1, 0]]
  selected := {0, 3, 5, 6}

def e8_015 : Example 8 where
  tree := (.join .edge (.join (.join .edge .edge) (.join .edge (.join (.join .edge .edge) .edge))))
  table := #[#[0, 1, 2, 2, 2, 3, 2, 1], #[1, 0, 1, 1, 2, 3, 2, 1], #[2, 1, 0, 1, 2, 3, 3, 2], #[2, 1, 1, 0, 1, 2, 2, 1], #[2, 2, 2, 1, 0, 1, 1, 1], #[3, 3, 3, 2, 1, 0, 1, 2], #[2, 2, 3, 2, 1, 1, 0, 1], #[1, 1, 2, 1, 1, 2, 1, 0]]
  selected := {0, 3, 4, 6}

def e8_016 : Example 8 where
  tree := (.join .edge (.join (.join .edge .edge) (.join (.join .edge .edge) (.join .edge .edge))))
  table := #[#[0, 1, 2, 2, 3, 2, 2, 1], #[1, 0, 1, 1, 2, 2, 2, 1], #[2, 1, 0, 1, 2, 2, 3, 2], #[2, 1, 1, 0, 1, 1, 2, 1], #[3, 2, 2, 1, 0, 1, 2, 2], #[2, 2, 2, 1, 1, 0, 1, 1], #[2, 2, 3, 2, 2, 1, 0, 1], #[1, 1, 2, 1, 2, 1, 1, 0]]
  selected := {0, 3, 5, 6}

def e8_017 : Example 8 where
  tree := (.join .edge (.join (.join .edge .edge) (.join (.join .edge (.join .edge .edge)) .edge)))
  table := #[#[0, 1, 2, 2, 3, 3, 2, 1], #[1, 0, 1, 1, 2, 3, 2, 1], #[2, 1, 0, 1, 2, 3, 2, 2], #[2, 1, 1, 0, 1, 2, 1, 1], #[3, 2, 2, 1, 0, 1, 1, 2], #[3, 3, 3, 2, 1, 0, 1, 2], #[2, 2, 2, 1, 1, 1, 0, 1], #[1, 1, 2, 1, 2, 2, 1, 0]]
  selected := {0, 2, 5, 6}

def e8_018 : Example 8 where
  tree := (.join .edge (.join (.join .edge .edge) (.join (.join (.join .edge .edge) .edge) .edge)))
  table := #[#[0, 1, 2, 2, 3, 3, 2, 1], #[1, 0, 1, 1, 2, 2, 2, 1], #[2, 1, 0, 1, 2, 2, 2, 2], #[2, 1, 1, 0, 1, 1, 1, 1], #[3, 2, 2, 1, 0, 1, 2, 2], #[3, 2, 2, 1, 1, 0, 1, 2], #[2, 2, 2, 1, 2, 1, 0, 1], #[1, 1, 2, 1, 2, 2, 1, 0]]
  selected := {0, 2, 4, 6}

def e8_019 : Example 8 where
  tree := (.join .edge (.join (.join .edge (.join .edge .edge)) (.join .edge (.join .edge .edge))))
  table := #[#[0, 1, 2, 3, 2, 2, 2, 1], #[1, 0, 1, 2, 1, 2, 2, 1], #[2, 1, 0, 1, 1, 2, 3, 2], #[3, 2, 1, 0, 1, 2, 3, 2], #[2, 1, 1, 1, 0, 1, 2, 1], #[2, 2, 2, 2, 1, 0, 1, 1], #[2, 2, 3, 3, 2, 1, 0, 1], #[1, 1, 2, 2, 1, 1, 1, 0]]
  selected := {0, 3, 5, 6}

def e8_020 : Example 8 where
  tree := (.join .edge (.join (.join .edge (.join .edge .edge)) (.join (.join .edge .edge) .edge)))
  table := #[#[0, 1, 2, 3, 2, 3, 2, 1], #[1, 0, 1, 2, 1, 2, 2, 1], #[2, 1, 0, 1, 1, 2, 2, 2], #[3, 2, 1, 0, 1, 2, 2, 2], #[2, 1, 1, 1, 0, 1, 1, 1], #[3, 2, 2, 2, 1, 0, 1, 2], #[2, 2, 2, 2, 1, 1, 0, 1], #[1, 1, 2, 2, 1, 2, 1, 0]]
  selected := {1, 3, 5, 6}

def e8_021 : Example 8 where
  tree := (.join .edge (.join (.join (.join .edge .edge) .edge) (.join .edge (.join .edge .edge))))
  table := #[#[0, 1, 2, 2, 2, 2, 2, 1], #[1, 0, 1, 1, 1, 2, 2, 1], #[2, 1, 0, 1, 2, 3, 3, 2], #[2, 1, 1, 0, 1, 2, 3, 2], #[2, 1, 2, 1, 0, 1, 2, 1], #[2, 2, 3, 2, 1, 0, 1, 1], #[2, 2, 3, 3, 2, 1, 0, 1], #[1, 1, 2, 2, 1, 1, 1, 0]]
  selected := {0, 3, 5, 6}

def e8_022 : Example 8 where
  tree := (.join .edge (.join (.join (.join .edge .edge) .edge) (.join (.join .edge .edge) .edge)))
  table := #[#[0, 1, 2, 2, 2, 3, 2, 1], #[1, 0, 1, 1, 1, 2, 2, 1], #[2, 1, 0, 1, 2, 3, 3, 2], #[2, 1, 1, 0, 1, 2, 2, 2], #[2, 1, 2, 1, 0, 1, 1, 1], #[3, 2, 3, 2, 1, 0, 1, 2], #[2, 2, 3, 2, 1, 1, 0, 1], #[1, 1, 2, 2, 1, 2, 1, 0]]
  selected := {0, 3, 5, 6}

def e8_023 : Example 8 where
  tree := (.join .edge (.join (.join .edge (.join .edge (.join .edge .edge))) (.join .edge .edge)))
  table := #[#[0, 1, 2, 3, 3, 2, 2, 1], #[1, 0, 1, 2, 2, 1, 2, 1], #[2, 1, 0, 1, 2, 1, 2, 2], #[3, 2, 1, 0, 1, 1, 2, 2], #[3, 2, 2, 1, 0, 1, 2, 2], #[2, 1, 1, 1, 1, 0, 1, 1], #[2, 2, 2, 2, 2, 1, 0, 1], #[1, 1, 2, 2, 2, 1, 1, 0]]
  selected := {0, 2, 4, 6}

def e8_024 : Example 8 where
  tree := (.join .edge (.join (.join .edge (.join (.join .edge .edge) .edge)) (.join .edge .edge)))
  table := #[#[0, 1, 2, 3, 3, 2, 2, 1], #[1, 0, 1, 2, 2, 1, 2, 1], #[2, 1, 0, 1, 1, 1, 2, 2], #[3, 2, 1, 0, 1, 2, 3, 3], #[3, 2, 1, 1, 0, 1, 2, 2], #[2, 1, 1, 2, 1, 0, 1, 1], #[2, 2, 2, 3, 2, 1, 0, 1], #[1, 1, 2, 3, 2, 1, 1, 0]]
  selected := {0, 2, 4, 6}

def e8_025 : Example 8 where
  tree := (.join .edge (.join (.join (.join .edge .edge) (.join .edge .edge)) (.join .edge .edge)))
  table := #[#[0, 1, 2, 2, 3, 2, 2, 1], #[1, 0, 1, 1, 2, 1, 2, 1], #[2, 1, 0, 1, 2, 2, 3, 2], #[2, 1, 1, 0, 1, 1, 2, 2], #[3, 2, 2, 1, 0, 1, 2, 2], #[2, 1, 2, 1, 1, 0, 1, 1], #[2, 2, 3, 2, 2, 1, 0, 1], #[1, 1, 2, 2, 2, 1, 1, 0]]
  selected := {0, 2, 4, 6}

def e8_026 : Example 8 where
  tree := (.join .edge (.join (.join (.join .edge (.join .edge .edge)) .edge) (.join .edge .edge)))
  table := #[#[0, 1, 2, 3, 2, 2, 2, 1], #[1, 0, 1, 2, 1, 1, 2, 1], #[2, 1, 0, 1, 1, 2, 3, 2], #[3, 2, 1, 0, 1, 2, 3, 3], #[2, 1, 1, 1, 0, 1, 2, 2], #[2, 1, 2, 2, 1, 0, 1, 1], #[2, 2, 3, 3, 2, 1, 0, 1], #[1, 1, 2, 3, 2, 1, 1, 0]]
  selected := {0, 2, 4, 6}

def e8_027 : Example 8 where
  tree := (.join .edge (.join (.join (.join (.join .edge .edge) .edge) .edge) (.join .edge .edge)))
  table := #[#[0, 1, 2, 2, 2, 2, 2, 1], #[1, 0, 1, 1, 1, 1, 2, 1], #[2, 1, 0, 1, 2, 2, 3, 2], #[2, 1, 1, 0, 1, 2, 3, 2], #[2, 1, 2, 1, 0, 1, 2, 2], #[2, 1, 2, 2, 1, 0, 1, 1], #[2, 2, 3, 3, 2, 1, 0, 1], #[1, 1, 2, 2, 2, 1, 1, 0]]
  selected := {0, 3, 4, 6}

def e8_028 : Example 8 where
  tree := (.join .edge (.join (.join .edge (.join .edge (.join .edge (.join .edge .edge)))) .edge))
  table := #[#[0, 1, 2, 3, 3, 3, 2, 1], #[1, 0, 1, 2, 2, 2, 1, 1], #[2, 1, 0, 1, 2, 2, 1, 2], #[3, 2, 1, 0, 1, 2, 1, 2], #[3, 2, 2, 1, 0, 1, 1, 2], #[3, 2, 2, 2, 1, 0, 1, 2], #[2, 1, 1, 1, 1, 1, 0, 1], #[1, 1, 2, 2, 2, 2, 1, 0]]
  selected := {1, 3, 5, 7}

def e8_029 : Example 8 where
  tree := (.join .edge (.join (.join .edge (.join .edge (.join (.join .edge .edge) .edge))) .edge))
  table := #[#[0, 1, 2, 3, 4, 3, 2, 1], #[1, 0, 1, 2, 3, 2, 1, 1], #[2, 1, 0, 1, 2, 2, 1, 2], #[3, 2, 1, 0, 1, 1, 1, 2], #[4, 3, 2, 1, 0, 1, 2, 3], #[3, 2, 2, 1, 1, 0, 1, 2], #[2, 1, 1, 1, 2, 1, 0, 1], #[1, 1, 2, 2, 3, 2, 1, 0]]
  selected := {1, 3, 5, 7}

def e8_030 : Example 8 where
  tree := (.join .edge (.join (.join .edge (.join (.join .edge .edge) (.join .edge .edge))) .edge))
  table := #[#[0, 1, 2, 3, 3, 3, 2, 1], #[1, 0, 1, 2, 2, 2, 1, 1], #[2, 1, 0, 1, 1, 2, 1, 2], #[3, 2, 1, 0, 1, 2, 2, 3], #[3, 2, 1, 1, 0, 1, 1, 2], #[3, 2, 2, 2, 1, 0, 1, 2], #[2, 1, 1, 2, 1, 1, 0, 1], #[1, 1, 2, 3, 2, 2, 1, 0]]
  selected := {1, 3, 4, 6}

def e8_031 : Example 8 where
  tree := (.join .edge (.join (.join .edge (.join (.join .edge (.join .edge .edge)) .edge)) .edge))
  table := #[#[0, 1, 2, 3, 4, 3, 2, 1], #[1, 0, 1, 2, 3, 2, 1, 1], #[2, 1, 0, 1, 2, 1, 1, 2], #[3, 2, 1, 0, 1, 1, 2, 3], #[4, 3, 2, 1, 0, 1, 2, 3], #[3, 2, 1, 1, 1, 0, 1, 2], #[2, 1, 1, 2, 2, 1, 0, 1], #[1, 1, 2, 3, 3, 2, 1, 0]]
  selected := {1, 3, 4, 6}

def e8_032 : Example 8 where
  tree := (.join .edge (.join (.join .edge (.join (.join (.join .edge .edge) .edge) .edge)) .edge))
  table := #[#[0, 1, 2, 3, 3, 3, 2, 1], #[1, 0, 1, 2, 2, 2, 1, 1], #[2, 1, 0, 1, 1, 1, 1, 2], #[3, 2, 1, 0, 1, 2, 2, 3], #[3, 2, 1, 1, 0, 1, 2, 3], #[3, 2, 1, 2, 1, 0, 1, 2], #[2, 1, 1, 2, 2, 1, 0, 1], #[1, 1, 2, 3, 3, 2, 1, 0]]
  selected := {1, 3, 5, 6}

def e8_033 : Example 8 where
  tree := (.join .edge (.join (.join (.join .edge .edge) (.join .edge (.join .edge .edge))) .edge))
  table := #[#[0, 1, 2, 2, 3, 3, 2, 1], #[1, 0, 1, 1, 2, 2, 1, 1], #[2, 1, 0, 1, 2, 3, 2, 2], #[2, 1, 1, 0, 1, 2, 1, 2], #[3, 2, 2, 1, 0, 1, 1, 2], #[3, 2, 3, 2, 1, 0, 1, 2], #[2, 1, 2, 1, 1, 1, 0, 1], #[1, 1, 2, 2, 2, 2, 1, 0]]
  selected := {1, 3, 4, 6}

def e8_034 : Example 8 where
  tree := (.join .edge (.join (.join (.join .edge .edge) (.join (.join .edge .edge) .edge)) .edge))
  table := #[#[0, 1, 2, 2, 3, 3, 2, 1], #[1, 0, 1, 1, 2, 2, 1, 1], #[2, 1, 0, 1, 2, 2, 2, 2], #[2, 1, 1, 0, 1, 1, 1, 2], #[3, 2, 2, 1, 0, 1, 2, 3], #[3, 2, 2, 1, 1, 0, 1, 2], #[2, 1, 2, 1, 2, 1, 0, 1], #[1, 1, 2, 2, 3, 2, 1, 0]]
  selected := {1, 3, 5, 6}

def e8_035 : Example 8 where
  tree := (.join .edge (.join (.join (.join .edge (.join .edge .edge)) (.join .edge .edge)) .edge))
  table := #[#[0, 1, 2, 3, 2, 3, 2, 1], #[1, 0, 1, 2, 1, 2, 1, 1], #[2, 1, 0, 1, 1, 2, 2, 2], #[3, 2, 1, 0, 1, 2, 2, 3], #[2, 1, 1, 1, 0, 1, 1, 2], #[3, 2, 2, 2, 1, 0, 1, 2], #[2, 1, 2, 2, 1, 1, 0, 1], #[1, 1, 2, 3, 2, 2, 1, 0]]
  selected := {0, 2, 4, 6}

def e8_036 : Example 8 where
  tree := (.join .edge (.join (.join (.join (.join .edge .edge) .edge) (.join .edge .edge)) .edge))
  table := #[#[0, 1, 2, 2, 2, 3, 2, 1], #[1, 0, 1, 1, 1, 2, 1, 1], #[2, 1, 0, 1, 2, 3, 2, 2], #[2, 1, 1, 0, 1, 2, 2, 2], #[2, 1, 2, 1, 0, 1, 1, 2], #[3, 2, 3, 2, 1, 0, 1, 2], #[2, 1, 2, 2, 1, 1, 0, 1], #[1, 1, 2, 2, 2, 2, 1, 0]]
  selected := {0, 3, 4, 6}

def e8_037 : Example 8 where
  tree := (.join .edge (.join (.join (.join .edge (.join .edge (.join .edge .edge))) .edge) .edge))
  table := #[#[0, 1, 2, 3, 3, 2, 2, 1], #[1, 0, 1, 2, 2, 1, 1, 1], #[2, 1, 0, 1, 2, 1, 2, 2], #[3, 2, 1, 0, 1, 1, 2, 3], #[3, 2, 2, 1, 0, 1, 2, 3], #[2, 1, 1, 1, 1, 0, 1, 2], #[2, 1, 2, 2, 2, 1, 0, 1], #[1, 1, 2, 3, 3, 2, 1, 0]]
  selected := {0, 2, 4, 6}

def e8_038 : Example 8 where
  tree := (.join .edge (.join (.join (.join .edge (.join (.join .edge .edge) .edge)) .edge) .edge))
  table := #[#[0, 1, 2, 3, 3, 2, 2, 1], #[1, 0, 1, 2, 2, 1, 1, 1], #[2, 1, 0, 1, 1, 1, 2, 2], #[3, 2, 1, 0, 1, 2, 3, 3], #[3, 2, 1, 1, 0, 1, 2, 3], #[2, 1, 1, 2, 1, 0, 1, 2], #[2, 1, 2, 3, 2, 1, 0, 1], #[1, 1, 2, 3, 3, 2, 1, 0]]
  selected := {0, 3, 4, 6}

def e8_039 : Example 8 where
  tree := (.join .edge (.join (.join (.join (.join .edge .edge) (.join .edge .edge)) .edge) .edge))
  table := #[#[0, 1, 2, 2, 3, 2, 2, 1], #[1, 0, 1, 1, 2, 1, 1, 1], #[2, 1, 0, 1, 2, 2, 2, 2], #[2, 1, 1, 0, 1, 1, 2, 2], #[3, 2, 2, 1, 0, 1, 2, 3], #[2, 1, 2, 1, 1, 0, 1, 2], #[2, 1, 2, 2, 2, 1, 0, 1], #[1, 1, 2, 2, 3, 2, 1, 0]]
  selected := {0, 3, 4, 6}

def e8_040 : Example 8 where
  tree := (.join .edge (.join (.join (.join (.join .edge (.join .edge .edge)) .edge) .edge) .edge))
  table := #[#[0, 1, 2, 3, 2, 2, 2, 1], #[1, 0, 1, 2, 1, 1, 1, 1], #[2, 1, 0, 1, 1, 2, 2, 2], #[3, 2, 1, 0, 1, 2, 3, 3], #[2, 1, 1, 1, 0, 1, 2, 2], #[2, 1, 2, 2, 1, 0, 1, 2], #[2, 1, 2, 3, 2, 1, 0, 1], #[1, 1, 2, 3, 2, 2, 1, 0]]
  selected := {0, 2, 5, 6}

def e8_041 : Example 8 where
  tree := (.join .edge (.join (.join (.join (.join (.join .edge .edge) .edge) .edge) .edge) .edge))
  table := #[#[0, 1, 2, 2, 2, 2, 2, 1], #[1, 0, 1, 1, 1, 1, 1, 1], #[2, 1, 0, 1, 2, 2, 2, 2], #[2, 1, 1, 0, 1, 2, 2, 2], #[2, 1, 2, 1, 0, 1, 2, 2], #[2, 1, 2, 2, 1, 0, 1, 2], #[2, 1, 2, 2, 2, 1, 0, 1], #[1, 1, 2, 2, 2, 2, 1, 0]]
  selected := {0, 2, 4, 6}

def e8_042 : Example 8 where
  tree := (.join (.join .edge .edge) (.join .edge (.join .edge (.join .edge (.join .edge .edge)))))
  table := #[#[0, 1, 1, 2, 2, 2, 2, 1], #[1, 0, 1, 2, 3, 3, 3, 2], #[1, 1, 0, 1, 2, 2, 2, 1], #[2, 2, 1, 0, 1, 2, 2, 1], #[2, 3, 2, 1, 0, 1, 2, 1], #[2, 3, 2, 2, 1, 0, 1, 1], #[2, 3, 2, 2, 2, 1, 0, 1], #[1, 2, 1, 1, 1, 1, 1, 0]]
  selected := {0, 2, 4, 6}

def e8_043 : Example 8 where
  tree := (.join (.join .edge .edge) (.join .edge (.join .edge (.join (.join .edge .edge) .edge))))
  table := #[#[0, 1, 1, 2, 2, 3, 2, 1], #[1, 0, 1, 2, 3, 4, 3, 2], #[1, 1, 0, 1, 2, 3, 2, 1], #[2, 2, 1, 0, 1, 2, 2, 1], #[2, 3, 2, 1, 0, 1, 1, 1], #[3, 4, 3, 2, 1, 0, 1, 2], #[2, 3, 2, 2, 1, 1, 0, 1], #[1, 2, 1, 1, 1, 2, 1, 0]]
  selected := {0, 2, 4, 6}

def e8_044 : Example 8 where
  tree := (.join (.join .edge .edge) (.join .edge (.join (.join .edge .edge) (.join .edge .edge))))
  table := #[#[0, 1, 1, 2, 3, 2, 2, 1], #[1, 0, 1, 2, 3, 3, 3, 2], #[1, 1, 0, 1, 2, 2, 2, 1], #[2, 2, 1, 0, 1, 1, 2, 1], #[3, 3, 2, 1, 0, 1, 2, 2], #[2, 3, 2, 1, 1, 0, 1, 1], #[2, 3, 2, 2, 2, 1, 0, 1], #[1, 2, 1, 1, 2, 1, 1, 0]]
  selected := {1, 2, 4, 6}

def e8_045 : Example 8 where
  tree := (.join (.join .edge .edge) (.join .edge (.join (.join .edge (.join .edge .edge)) .edge)))
  table := #[#[0, 1, 1, 2, 3, 3, 2, 1], #[1, 0, 1, 2, 3, 4, 3, 2], #[1, 1, 0, 1, 2, 3, 2, 1], #[2, 2, 1, 0, 1, 2, 1, 1], #[3, 3, 2, 1, 0, 1, 1, 2], #[3, 4, 3, 2, 1, 0, 1, 2], #[2, 3, 2, 1, 1, 1, 0, 1], #[1, 2, 1, 1, 2, 2, 1, 0]]
  selected := {1, 3, 4, 6}

def e8_046 : Example 8 where
  tree := (.join (.join .edge .edge) (.join .edge (.join (.join (.join .edge .edge) .edge) .edge)))
  table := #[#[0, 1, 1, 2, 3, 3, 2, 1], #[1, 0, 1, 2, 3, 3, 3, 2], #[1, 1, 0, 1, 2, 2, 2, 1], #[2, 2, 1, 0, 1, 1, 1, 1], #[3, 3, 2, 1, 0, 1, 2, 2], #[3, 3, 2, 1, 1, 0, 1, 2], #[2, 3, 2, 1, 2, 1, 0, 1], #[1, 2, 1, 1, 2, 2, 1, 0]]
  selected := {1, 3, 4, 6}

def e8_047 : Example 8 where
  tree := (.join (.join .edge .edge) (.join (.join .edge .edge) (.join .edge (.join .edge .edge))))
  table := #[#[0, 1, 1, 2, 2, 2, 2, 1], #[1, 0, 1, 2, 2, 3, 3, 2], #[1, 1, 0, 1, 1, 2, 2, 1], #[2, 2, 1, 0, 1, 2, 3, 2], #[2, 2, 1, 1, 0, 1, 2, 1], #[2, 3, 2, 2, 1, 0, 1, 1], #[2, 3, 2, 3, 2, 1, 0, 1], #[1, 2, 1, 2, 1, 1, 1, 0]]
  selected := {1, 3, 4, 7}

def e8_048 : Example 8 where
  tree := (.join (.join .edge .edge) (.join (.join .edge .edge) (.join (.join .edge .edge) .edge)))
  table := #[#[0, 1, 1, 2, 2, 3, 2, 1], #[1, 0, 1, 2, 2, 3, 3, 2], #[1, 1, 0, 1, 1, 2, 2, 1], #[2, 2, 1, 0, 1, 2, 2, 2], #[2, 2, 1, 1, 0, 1, 1, 1], #[3, 3, 2, 2, 1, 0, 1, 2], #[2, 3, 2, 2, 1, 1, 0, 1], #[1, 2, 1, 2, 1, 2, 1, 0]]
  selected := {1, 3, 5, 6}

def e8_049 : Example 8 where
  tree := (.join (.join .edge .edge) (.join (.join .edge (.join .edge .edge)) (.join .edge .edge)))
  table := #[#[0, 1, 1, 2, 3, 2, 2, 1], #[1, 0, 1, 2, 3, 2, 3, 2], #[1, 1, 0, 1, 2, 1, 2, 1], #[2, 2, 1, 0, 1, 1, 2, 2], #[3, 3, 2, 1, 0, 1, 2, 2], #[2, 2, 1, 1, 1, 0, 1, 1], #[2, 3, 2, 2, 2, 1, 0, 1], #[1, 2, 1, 2, 2, 1, 1, 0]]
  selected := {1, 3, 4, 6}

def e8_050 : Example 8 where
  tree := (.join (.join .edge .edge) (.join (.join (.join .edge .edge) .edge) (.join .edge .edge)))
  table := #[#[0, 1, 1, 2, 2, 2, 2, 1], #[1, 0, 1, 2, 2, 2, 3, 2], #[1, 1, 0, 1, 1, 1, 2, 1], #[2, 2, 1, 0, 1, 2, 3, 2], #[2, 2, 1, 1, 0, 1, 2, 2], #[2, 2, 1, 2, 1, 0, 1, 1], #[2, 3, 2, 3, 2, 1, 0, 1], #[1, 2, 1, 2, 2, 1, 1, 0]]
  selected := {1, 3, 5, 7}

def e8_051 : Example 8 where
  tree := (.join (.join .edge .edge) (.join (.join .edge (.join .edge (.join .edge .edge))) .edge))
  table := #[#[0, 1, 1, 2, 3, 3, 2, 1], #[1, 0, 1, 2, 3, 3, 2, 2], #[1, 1, 0, 1, 2, 2, 1, 1], #[2, 2, 1, 0, 1, 2, 1, 2], #[3, 3, 2, 1, 0, 1, 1, 2], #[3, 3, 2, 2, 1, 0, 1, 2], #[2, 2, 1, 1, 1, 1, 0, 1], #[1, 2, 1, 2, 2, 2, 1, 0]]
  selected := {1, 3, 5, 7}

def e8_052 : Example 8 where
  tree := (.join (.join .edge .edge) (.join (.join .edge (.join (.join .edge .edge) .edge)) .edge))
  table := #[#[0, 1, 1, 2, 3, 3, 2, 1], #[1, 0, 1, 2, 3, 3, 2, 2], #[1, 1, 0, 1, 2, 2, 1, 1], #[2, 2, 1, 0, 1, 1, 1, 2], #[3, 3, 2, 1, 0, 1, 2, 3], #[3, 3, 2, 1, 1, 0, 1, 2], #[2, 2, 1, 1, 2, 1, 0, 1], #[1, 2, 1, 2, 3, 2, 1, 0]]
  selected := {1, 3, 5, 7}

def e8_053 : Example 8 where
  tree := (.join (.join .edge .edge) (.join (.join (.join .edge .edge) (.join .edge .edge)) .edge))
  table := #[#[0, 1, 1, 2, 2, 3, 2, 1], #[1, 0, 1, 2, 2, 3, 2, 2], #[1, 1, 0, 1, 1, 2, 1, 1], #[2, 2, 1, 0, 1, 2, 2, 2], #[2, 2, 1, 1, 0, 1, 1, 2], #[3, 3, 2, 2, 1, 0, 1, 2], #[2, 2, 1, 2, 1, 1, 0, 1], #[1, 2, 1, 2, 2, 2, 1, 0]]
  selected := {1, 3, 5, 7}

def e8_054 : Example 8 where
  tree := (.join (.join .edge .edge) (.join (.join (.join .edge (.join .edge .edge)) .edge) .edge))
  table := #[#[0, 1, 1, 2, 3, 2, 2, 1], #[1, 0, 1, 2, 3, 2, 2, 2], #[1, 1, 0, 1, 2, 1, 1, 1], #[2, 2, 1, 0, 1, 1, 2, 2], #[3, 3, 2, 1, 0, 1, 2, 3], #[2, 2, 1, 1, 1, 0, 1, 2], #[2, 2, 1, 2, 2, 1, 0, 1], #[1, 2, 1, 2, 3, 2, 1, 0]]
  selected := {1, 3, 5, 7}

def e8_055 : Example 8 where
  tree := (.join (.join .edge .edge) (.join (.join (.join (.join .edge .edge) .edge) .edge) .edge))
  table := #[#[0, 1, 1, 2, 2, 2, 2, 1], #[1, 0, 1, 2, 2, 2, 2, 2], #[1, 1, 0, 1, 1, 1, 1, 1], #[2, 2, 1, 0, 1, 2, 2, 2], #[2, 2, 1, 1, 0, 1, 2, 2], #[2, 2, 1, 2, 1, 0, 1, 2], #[2, 2, 1, 2, 2, 1, 0, 1], #[1, 2, 1, 2, 2, 2, 1, 0]]
  selected := {1, 3, 5, 7}

def e8_056 : Example 8 where
  tree := (.join (.join .edge (.join .edge .edge)) (.join .edge (.join .edge (.join .edge .edge))))
  table := #[#[0, 1, 2, 1, 2, 2, 2, 1], #[1, 0, 1, 1, 2, 3, 3, 2], #[2, 1, 0, 1, 2, 3, 3, 2], #[1, 1, 1, 0, 1, 2, 2, 1], #[2, 2, 2, 1, 0, 1, 2, 1], #[2, 3, 3, 2, 1, 0, 1, 1], #[2, 3, 3, 2, 2, 1, 0, 1], #[1, 2, 2, 1, 1, 1, 1, 0]]
  selected := {1, 2, 4, 6}

def e8_057 : Example 8 where
  tree := (.join (.join .edge (.join .edge .edge)) (.join .edge (.join (.join .edge .edge) .edge)))
  table := #[#[0, 1, 2, 1, 2, 3, 2, 1], #[1, 0, 1, 1, 2, 3, 3, 2], #[2, 1, 0, 1, 2, 3, 3, 2], #[1, 1, 1, 0, 1, 2, 2, 1], #[2, 2, 2, 1, 0, 1, 1, 1], #[3, 3, 3, 2, 1, 0, 1, 2], #[2, 3, 3, 2, 1, 1, 0, 1], #[1, 2, 2, 1, 1, 2, 1, 0]]
  selected := {1, 2, 5, 7}

def e8_058 : Example 8 where
  tree := (.join (.join .edge (.join .edge .edge)) (.join (.join .edge .edge) (.join .edge .edge)))
  table := #[#[0, 1, 2, 1, 2, 2, 2, 1], #[1, 0, 1, 1, 2, 2, 3, 2], #[2, 1, 0, 1, 2, 2, 3, 2], #[1, 1, 1, 0, 1, 1, 2, 1], #[2, 2, 2, 1, 0, 1, 2, 2], #[2, 2, 2, 1, 1, 0, 1, 1], #[2, 3, 3, 2, 2, 1, 0, 1], #[1, 2, 2, 1, 2, 1, 1, 0]]
  selected := {0, 2, 4, 6}

def e8_059 : Example 8 where
  tree := (.join (.join .edge (.join .edge .edge)) (.join (.join .edge (.join .edge .edge)) .edge))
  table := #[#[0, 1, 2, 1, 2, 3, 2, 1], #[1, 0, 1, 1, 2, 3, 2, 2], #[2, 1, 0, 1, 2, 3, 2, 2], #[1, 1, 1, 0, 1, 2, 1, 1], #[2, 2, 2, 1, 0, 1, 1, 2], #[3, 3, 3, 2, 1, 0, 1, 2], #[2, 2, 2, 1, 1, 1, 0, 1], #[1, 2, 2, 1, 2, 2, 1, 0]]
  selected := {0, 2, 4, 6}

def e8_060 : Example 8 where
  tree := (.join (.join .edge (.join .edge .edge)) (.join (.join (.join .edge .edge) .edge) .edge))
  table := #[#[0, 1, 2, 1, 2, 2, 2, 1], #[1, 0, 1, 1, 2, 2, 2, 2], #[2, 1, 0, 1, 2, 2, 2, 2], #[1, 1, 1, 0, 1, 1, 1, 1], #[2, 2, 2, 1, 0, 1, 2, 2], #[2, 2, 2, 1, 1, 0, 1, 2], #[2, 2, 2, 1, 2, 1, 0, 1], #[1, 2, 2, 1, 2, 2, 1, 0]]
  selected := {0, 2, 4, 6}

def e8_061 : Example 8 where
  tree := (.join (.join (.join .edge .edge) .edge) (.join .edge (.join .edge (.join .edge .edge))))
  table := #[#[0, 1, 1, 1, 2, 2, 2, 1], #[1, 0, 1, 2, 3, 3, 3, 2], #[1, 1, 0, 1, 2, 3, 3, 2], #[1, 2, 1, 0, 1, 2, 2, 1], #[2, 3, 2, 1, 0, 1, 2, 1], #[2, 3, 3, 2, 1, 0, 1, 1], #[2, 3, 3, 2, 2, 1, 0, 1], #[1, 2, 2, 1, 1, 1, 1, 0]]
  selected := {1, 3, 5, 6}

def e8_062 : Example 8 where
  tree := (.join (.join (.join .edge .edge) .edge) (.join .edge (.join (.join .edge .edge) .edge)))
  table := #[#[0, 1, 1, 1, 2, 3, 2, 1], #[1, 0, 1, 2, 3, 4, 3, 2], #[1, 1, 0, 1, 2, 3, 3, 2], #[1, 2, 1, 0, 1, 2, 2, 1], #[2, 3, 2, 1, 0, 1, 1, 1], #[3, 4, 3, 2, 1, 0, 1, 2], #[2, 3, 3, 2, 1, 1, 0, 1], #[1, 2, 2, 1, 1, 2, 1, 0]]
  selected := {1, 2, 4, 6}

def e8_063 : Example 8 where
  tree := (.join (.join (.join .edge .edge) .edge) (.join (.join .edge .edge) (.join .edge .edge)))
  table := #[#[0, 1, 1, 1, 2, 2, 2, 1], #[1, 0, 1, 2, 3, 3, 3, 2], #[1, 1, 0, 1, 2, 2, 3, 2], #[1, 2, 1, 0, 1, 1, 2, 1], #[2, 3, 2, 1, 0, 1, 2, 2], #[2, 3, 2, 1, 1, 0, 1, 1], #[2, 3, 3, 2, 2, 1, 0, 1], #[1, 2, 2, 1, 2, 1, 1, 0]]
  selected := {1, 2, 5, 6}

def e8_064 : Example 8 where
  tree := (.join (.join (.join .edge .edge) .edge) (.join (.join .edge (.join .edge .edge)) .edge))
  table := #[#[0, 1, 1, 1, 2, 3, 2, 1], #[1, 0, 1, 2, 3, 4, 3, 2], #[1, 1, 0, 1, 2, 3, 2, 2], #[1, 2, 1, 0, 1, 2, 1, 1], #[2, 3, 2, 1, 0, 1, 1, 2], #[3, 4, 3, 2, 1, 0, 1, 2], #[2, 3, 2, 1, 1, 1, 0, 1], #[1, 2, 2, 1, 2, 2, 1, 0]]
  selected := {1, 2, 4, 7}

def e8_065 : Example 8 where
  tree := (.join (.join (.join .edge .edge) .edge) (.join (.join (.join .edge .edge) .edge) .edge))
  table := #[#[0, 1, 1, 1, 2, 2, 2, 1], #[1, 0, 1, 2, 3, 3, 3, 2], #[1, 1, 0, 1, 2, 2, 2, 2], #[1, 2, 1, 0, 1, 1, 1, 1], #[2, 3, 2, 1, 0, 1, 2, 2], #[2, 3, 2, 1, 1, 0, 1, 2], #[2, 3, 2, 1, 2, 1, 0, 1], #[1, 2, 2, 1, 2, 2, 1, 0]]
  selected := {0, 2, 4, 6}

def e8_066 : Example 8 where
  tree := (.join (.join .edge (.join .edge (.join .edge .edge))) (.join .edge (.join .edge .edge)))
  table := #[#[0, 1, 2, 2, 1, 2, 2, 1], #[1, 0, 1, 2, 1, 2, 3, 2], #[2, 1, 0, 1, 1, 2, 3, 2], #[2, 2, 1, 0, 1, 2, 3, 2], #[1, 1, 1, 1, 0, 1, 2, 1], #[2, 2, 2, 2, 1, 0, 1, 1], #[2, 3, 3, 3, 2, 1, 0, 1], #[1, 2, 2, 2, 1, 1, 1, 0]]
  selected := {1, 3, 5, 7}

def e8_067 : Example 8 where
  tree := (.join (.join .edge (.join .edge (.join .edge .edge))) (.join (.join .edge .edge) .edge))
  table := #[#[0, 1, 2, 2, 1, 2, 2, 1], #[1, 0, 1, 2, 1, 2, 2, 2], #[2, 1, 0, 1, 1, 2, 2, 2], #[2, 2, 1, 0, 1, 2, 2, 2], #[1, 1, 1, 1, 0, 1, 1, 1], #[2, 2, 2, 2, 1, 0, 1, 2], #[2, 2, 2, 2, 1, 1, 0, 1], #[1, 2, 2, 2, 1, 2, 1, 0]]
  selected := {1, 3, 5, 7}

def e8_068 : Example 8 where
  tree := (.join (.join .edge (.join (.join .edge .edge) .edge)) (.join .edge (.join .edge .edge)))
  table := #[#[0, 1, 2, 2, 1, 2, 2, 1], #[1, 0, 1, 1, 1, 2, 3, 2], #[2, 1, 0, 1, 2, 3, 4, 3], #[2, 1, 1, 0, 1, 2, 3, 2], #[1, 1, 2, 1, 0, 1, 2, 1], #[2, 2, 3, 2, 1, 0, 1, 1], #[2, 3, 4, 3, 2, 1, 0, 1], #[1, 2, 3, 2, 1, 1, 1, 0]]
  selected := {1, 3, 5, 7}

def e8_069 : Example 8 where
  tree := (.join (.join .edge (.join (.join .edge .edge) .edge)) (.join (.join .edge .edge) .edge))
  table := #[#[0, 1, 2, 2, 1, 2, 2, 1], #[1, 0, 1, 1, 1, 2, 2, 2], #[2, 1, 0, 1, 2, 3, 3, 3], #[2, 1, 1, 0, 1, 2, 2, 2], #[1, 1, 2, 1, 0, 1, 1, 1], #[2, 2, 3, 2, 1, 0, 1, 2], #[2, 2, 3, 2, 1, 1, 0, 1], #[1, 2, 3, 2, 1, 2, 1, 0]]
  selected := {1, 3, 5, 7}

def e8_070 : Example 8 where
  tree := (.join (.join (.join .edge .edge) (.join .edge .edge)) (.join .edge (.join .edge .edge)))
  table := #[#[0, 1, 1, 2, 1, 2, 2, 1], #[1, 0, 1, 2, 2, 3, 3, 2], #[1, 1, 0, 1, 1, 2, 3, 2], #[2, 2, 1, 0, 1, 2, 3, 2], #[1, 2, 1, 1, 0, 1, 2, 1], #[2, 3, 2, 2, 1, 0, 1, 1], #[2, 3, 3, 3, 2, 1, 0, 1], #[1, 2, 2, 2, 1, 1, 1, 0]]
  selected := {1, 3, 5, 6}

def e8_071 : Example 8 where
  tree := (.join (.join (.join .edge .edge) (.join .edge .edge)) (.join (.join .edge .edge) .edge))
  table := #[#[0, 1, 1, 2, 1, 2, 2, 1], #[1, 0, 1, 2, 2, 3, 3, 2], #[1, 1, 0, 1, 1, 2, 2, 2], #[2, 2, 1, 0, 1, 2, 2, 2], #[1, 2, 1, 1, 0, 1, 1, 1], #[2, 3, 2, 2, 1, 0, 1, 2], #[2, 3, 2, 2, 1, 1, 0, 1], #[1, 2, 2, 2, 1, 2, 1, 0]]
  selected := {1, 3, 5, 7}

def e8_072 : Example 8 where
  tree := (.join (.join (.join .edge (.join .edge .edge)) .edge) (.join .edge (.join .edge .edge)))
  table := #[#[0, 1, 2, 1, 1, 2, 2, 1], #[1, 0, 1, 1, 2, 3, 3, 2], #[2, 1, 0, 1, 2, 3, 4, 3], #[1, 1, 1, 0, 1, 2, 3, 2], #[1, 2, 2, 1, 0, 1, 2, 1], #[2, 3, 3, 2, 1, 0, 1, 1], #[2, 3, 4, 3, 2, 1, 0, 1], #[1, 2, 3, 2, 1, 1, 1, 0]]
  selected := {1, 3, 5, 6}

def e8_073 : Example 8 where
  tree := (.join (.join (.join .edge (.join .edge .edge)) .edge) (.join (.join .edge .edge) .edge))
  table := #[#[0, 1, 2, 1, 1, 2, 2, 1], #[1, 0, 1, 1, 2, 3, 3, 2], #[2, 1, 0, 1, 2, 3, 3, 3], #[1, 1, 1, 0, 1, 2, 2, 2], #[1, 2, 2, 1, 0, 1, 1, 1], #[2, 3, 3, 2, 1, 0, 1, 2], #[2, 3, 3, 2, 1, 1, 0, 1], #[1, 2, 3, 2, 1, 2, 1, 0]]
  selected := {1, 3, 5, 7}

def e8_074 : Example 8 where
  tree := (.join (.join (.join (.join .edge .edge) .edge) .edge) (.join .edge (.join .edge .edge)))
  table := #[#[0, 1, 1, 1, 1, 2, 2, 1], #[1, 0, 1, 2, 2, 3, 3, 2], #[1, 1, 0, 1, 2, 3, 3, 2], #[1, 2, 1, 0, 1, 2, 3, 2], #[1, 2, 2, 1, 0, 1, 2, 1], #[2, 3, 3, 2, 1, 0, 1, 1], #[2, 3, 3, 3, 2, 1, 0, 1], #[1, 2, 2, 2, 1, 1, 1, 0]]
  selected := {1, 3, 5, 6}

def e8_075 : Example 8 where
  tree := (.join (.join (.join (.join .edge .edge) .edge) .edge) (.join (.join .edge .edge) .edge))
  table := #[#[0, 1, 1, 1, 1, 2, 2, 1], #[1, 0, 1, 2, 2, 3, 3, 2], #[1, 1, 0, 1, 2, 3, 3, 2], #[1, 2, 1, 0, 1, 2, 2, 2], #[1, 2, 2, 1, 0, 1, 1, 1], #[2, 3, 3, 2, 1, 0, 1, 2], #[2, 3, 3, 2, 1, 1, 0, 1], #[1, 2, 2, 2, 1, 2, 1, 0]]
  selected := {1, 3, 5, 6}

def e8_076 : Example 8 where
  tree := (.join (.join .edge (.join .edge (.join .edge (.join .edge .edge)))) (.join .edge .edge))
  table := #[#[0, 1, 2, 2, 2, 1, 2, 1], #[1, 0, 1, 2, 2, 1, 2, 2], #[2, 1, 0, 1, 2, 1, 2, 2], #[2, 2, 1, 0, 1, 1, 2, 2], #[2, 2, 2, 1, 0, 1, 2, 2], #[1, 1, 1, 1, 1, 0, 1, 1], #[2, 2, 2, 2, 2, 1, 0, 1], #[1, 2, 2, 2, 2, 1, 1, 0]]
  selected := {0, 2, 4, 6}

def e8_077 : Example 8 where
  tree := (.join (.join .edge (.join .edge (.join (.join .edge .edge) .edge))) (.join .edge .edge))
  table := #[#[0, 1, 2, 3, 2, 1, 2, 1], #[1, 0, 1, 2, 2, 1, 2, 2], #[2, 1, 0, 1, 1, 1, 2, 2], #[3, 2, 1, 0, 1, 2, 3, 3], #[2, 2, 1, 1, 0, 1, 2, 2], #[1, 1, 1, 2, 1, 0, 1, 1], #[2, 2, 2, 3, 2, 1, 0, 1], #[1, 2, 2, 3, 2, 1, 1, 0]]
  selected := {0, 2, 4, 6}

def e8_078 : Example 8 where
  tree := (.join (.join .edge (.join (.join .edge .edge) (.join .edge .edge))) (.join .edge .edge))
  table := #[#[0, 1, 2, 2, 2, 1, 2, 1], #[1, 0, 1, 1, 2, 1, 2, 2], #[2, 1, 0, 1, 2, 2, 3, 3], #[2, 1, 1, 0, 1, 1, 2, 2], #[2, 2, 2, 1, 0, 1, 2, 2], #[1, 1, 2, 1, 1, 0, 1, 1], #[2, 2, 3, 2, 2, 1, 0, 1], #[1, 2, 3, 2, 2, 1, 1, 0]]
  selected := {0, 3, 4, 6}

def e8_079 : Example 8 where
  tree := (.join (.join .edge (.join (.join .edge (.join .edge .edge)) .edge)) (.join .edge .edge))
  table := #[#[0, 1, 2, 3, 2, 1, 2, 1], #[1, 0, 1, 2, 1, 1, 2, 2], #[2, 1, 0, 1, 1, 2, 3, 3], #[3, 2, 1, 0, 1, 2, 3, 3], #[2, 1, 1, 1, 0, 1, 2, 2], #[1, 1, 2, 2, 1, 0, 1, 1], #[2, 2, 3, 3, 2, 1, 0, 1], #[1, 2, 3, 3, 2, 1, 1, 0]]
  selected := {0, 3, 5, 6}

def e8_080 : Example 8 where
  tree := (.join (.join .edge (.join (.join (.join .edge .edge) .edge) .edge)) (.join .edge .edge))
  table := #[#[0, 1, 2, 2, 2, 1, 2, 1], #[1, 0, 1, 1, 1, 1, 2, 2], #[2, 1, 0, 1, 2, 2, 3, 3], #[2, 1, 1, 0, 1, 2, 3, 3], #[2, 1, 2, 1, 0, 1, 2, 2], #[1, 1, 2, 2, 1, 0, 1, 1], #[2, 2, 3, 3, 2, 1, 0, 1], #[1, 2, 3, 3, 2, 1, 1, 0]]
  selected := {0, 2, 4, 6}

def e8_081 : Example 8 where
  tree := (.join (.join (.join .edge .edge) (.join .edge (.join .edge .edge))) (.join .edge .edge))
  table := #[#[0, 1, 1, 2, 2, 1, 2, 1], #[1, 0, 1, 2, 3, 2, 3, 2], #[1, 1, 0, 1, 2, 1, 2, 2], #[2, 2, 1, 0, 1, 1, 2, 2], #[2, 3, 2, 1, 0, 1, 2, 2], #[1, 2, 1, 1, 1, 0, 1, 1], #[2, 3, 2, 2, 2, 1, 0, 1], #[1, 2, 2, 2, 2, 1, 1, 0]]
  selected := {0, 3, 4, 6}

def e8_082 : Example 8 where
  tree := (.join (.join (.join .edge .edge) (.join (.join .edge .edge) .edge)) (.join .edge .edge))
  table := #[#[0, 1, 1, 2, 2, 1, 2, 1], #[1, 0, 1, 2, 2, 2, 3, 2], #[1, 1, 0, 1, 1, 1, 2, 2], #[2, 2, 1, 0, 1, 2, 3, 3], #[2, 2, 1, 1, 0, 1, 2, 2], #[1, 2, 1, 2, 1, 0, 1, 1], #[2, 3, 2, 3, 2, 1, 0, 1], #[1, 2, 2, 3, 2, 1, 1, 0]]
  selected := {1, 3, 4, 6}

def e8_083 : Example 8 where
  tree := (.join (.join (.join .edge (.join .edge .edge)) (.join .edge .edge)) (.join .edge .edge))
  table := #[#[0, 1, 2, 1, 2, 1, 2, 1], #[1, 0, 1, 1, 2, 2, 3, 2], #[2, 1, 0, 1, 2, 2, 3, 3], #[1, 1, 1, 0, 1, 1, 2, 2], #[2, 2, 2, 1, 0, 1, 2, 2], #[1, 2, 2, 1, 1, 0, 1, 1], #[2, 3, 3, 2, 2, 1, 0, 1], #[1, 2, 3, 2, 2, 1, 1, 0]]
  selected := {1, 2, 4, 6}

def e8_084 : Example 8 where
  tree := (.join (.join (.join (.join .edge .edge) .edge) (.join .edge .edge)) (.join .edge .edge))
  table := #[#[0, 1, 1, 1, 2, 1, 2, 1], #[1, 0, 1, 2, 3, 2, 3, 2], #[1, 1, 0, 1, 2, 2, 3, 2], #[1, 2, 1, 0, 1, 1, 2, 2], #[2, 3, 2, 1, 0, 1, 2, 2], #[1, 2, 2, 1, 1, 0, 1, 1], #[2, 3, 3, 2, 2, 1, 0, 1], #[1, 2, 2, 2, 2, 1, 1, 0]]
  selected := {1, 2, 5, 7}

def e8_085 : Example 8 where
  tree := (.join (.join (.join .edge (.join .edge (.join .edge .edge))) .edge) (.join .edge .edge))
  table := #[#[0, 1, 2, 2, 1, 1, 2, 1], #[1, 0, 1, 2, 1, 2, 3, 2], #[2, 1, 0, 1, 1, 2, 3, 3], #[2, 2, 1, 0, 1, 2, 3, 3], #[1, 1, 1, 1, 0, 1, 2, 2], #[1, 2, 2, 2, 1, 0, 1, 1], #[2, 3, 3, 3, 2, 1, 0, 1], #[1, 2, 3, 3, 2, 1, 1, 0]]
  selected := {1, 3, 4, 6}

def e8_086 : Example 8 where
  tree := (.join (.join (.join .edge (.join (.join .edge .edge) .edge)) .edge) (.join .edge .edge))
  table := #[#[0, 1, 2, 2, 1, 1, 2, 1], #[1, 0, 1, 1, 1, 2, 3, 2], #[2, 1, 0, 1, 2, 3, 4, 3], #[2, 1, 1, 0, 1, 2, 3, 3], #[1, 1, 2, 1, 0, 1, 2, 2], #[1, 2, 3, 2, 1, 0, 1, 1], #[2, 3, 4, 3, 2, 1, 0, 1], #[1, 2, 3, 3, 2, 1, 1, 0]]
  selected := {1, 3, 4, 6}

def e8_087 : Example 8 where
  tree := (.join (.join (.join (.join .edge .edge) (.join .edge .edge)) .edge) (.join .edge .edge))
  table := #[#[0, 1, 1, 2, 1, 1, 2, 1], #[1, 0, 1, 2, 2, 2, 3, 2], #[1, 1, 0, 1, 1, 2, 3, 2], #[2, 2, 1, 0, 1, 2, 3, 3], #[1, 2, 1, 1, 0, 1, 2, 2], #[1, 2, 2, 2, 1, 0, 1, 1], #[2, 3, 3, 3, 2, 1, 0, 1], #[1, 2, 2, 3, 2, 1, 1, 0]]
  selected := {1, 3, 5, 6}

def e8_088 : Example 8 where
  tree := (.join (.join (.join (.join .edge (.join .edge .edge)) .edge) .edge) (.join .edge .edge))
  table := #[#[0, 1, 2, 1, 1, 1, 2, 1], #[1, 0, 1, 1, 2, 2, 3, 2], #[2, 1, 0, 1, 2, 3, 4, 3], #[1, 1, 1, 0, 1, 2, 3, 2], #[1, 2, 2, 1, 0, 1, 2, 2], #[1, 2, 3, 2, 1, 0, 1, 1], #[2, 3, 4, 3, 2, 1, 0, 1], #[1, 2, 3, 2, 2, 1, 1, 0]]
  selected := {1, 3, 5, 7}

def e8_089 : Example 8 where
  tree := (.join (.join (.join (.join (.join .edge .edge) .edge) .edge) .edge) (.join .edge .edge))
  table := #[#[0, 1, 1, 1, 1, 1, 2, 1], #[1, 0, 1, 2, 2, 2, 3, 2], #[1, 1, 0, 1, 2, 2, 3, 2], #[1, 2, 1, 0, 1, 2, 3, 2], #[1, 2, 2, 1, 0, 1, 2, 2], #[1, 2, 2, 2, 1, 0, 1, 1], #[2, 3, 3, 3, 2, 1, 0, 1], #[1, 2, 2, 2, 2, 1, 1, 0]]
  selected := {1, 3, 5, 7}

def e8_090 : Example 8 where
  tree := (.join (.join .edge (.join .edge (.join .edge (.join .edge (.join .edge .edge))))) .edge)
  table := #[#[0, 1, 2, 2, 2, 2, 1, 1], #[1, 0, 1, 2, 2, 2, 1, 2], #[2, 1, 0, 1, 2, 2, 1, 2], #[2, 2, 1, 0, 1, 2, 1, 2], #[2, 2, 2, 1, 0, 1, 1, 2], #[2, 2, 2, 2, 1, 0, 1, 2], #[1, 1, 1, 1, 1, 1, 0, 1], #[1, 2, 2, 2, 2, 2, 1, 0]]
  selected := {1, 3, 5, 7}

def e8_091 : Example 8 where
  tree := (.join (.join .edge (.join .edge (.join .edge (.join (.join .edge .edge) .edge)))) .edge)
  table := #[#[0, 1, 2, 2, 3, 2, 1, 1], #[1, 0, 1, 2, 3, 2, 1, 2], #[2, 1, 0, 1, 2, 2, 1, 2], #[2, 2, 1, 0, 1, 1, 1, 2], #[3, 3, 2, 1, 0, 1, 2, 3], #[2, 2, 2, 1, 1, 0, 1, 2], #[1, 1, 1, 1, 2, 1, 0, 1], #[1, 2, 2, 2, 3, 2, 1, 0]]
  selected := {1, 3, 5, 7}

def e8_092 : Example 8 where
  tree := (.join (.join .edge (.join .edge (.join (.join .edge .edge) (.join .edge .edge)))) .edge)
  table := #[#[0, 1, 2, 3, 2, 2, 1, 1], #[1, 0, 1, 2, 2, 2, 1, 2], #[2, 1, 0, 1, 1, 2, 1, 2], #[3, 2, 1, 0, 1, 2, 2, 3], #[2, 2, 1, 1, 0, 1, 1, 2], #[2, 2, 2, 2, 1, 0, 1, 2], #[1, 1, 1, 2, 1, 1, 0, 1], #[1, 2, 2, 3, 2, 2, 1, 0]]
  selected := {1, 2, 5, 7}

def e8_093 : Example 8 where
  tree := (.join (.join .edge (.join .edge (.join (.join .edge (.join .edge .edge)) .edge))) .edge)
  table := #[#[0, 1, 2, 3, 3, 2, 1, 1], #[1, 0, 1, 2, 3, 2, 1, 2], #[2, 1, 0, 1, 2, 1, 1, 2], #[3, 2, 1, 0, 1, 1, 2, 3], #[3, 3, 2, 1, 0, 1, 2, 3], #[2, 2, 1, 1, 1, 0, 1, 2], #[1, 1, 1, 2, 2, 1, 0, 1], #[1, 2, 2, 3, 3, 2, 1, 0]]
  selected := {1, 3, 4, 7}

def e8_094 : Example 8 where
  tree := (.join (.join .edge (.join .edge (.join (.join (.join .edge .edge) .edge) .edge))) .edge)
  table := #[#[0, 1, 2, 3, 3, 2, 1, 1], #[1, 0, 1, 2, 2, 2, 1, 2], #[2, 1, 0, 1, 1, 1, 1, 2], #[3, 2, 1, 0, 1, 2, 2, 3], #[3, 2, 1, 1, 0, 1, 2, 3], #[2, 2, 1, 2, 1, 0, 1, 2], #[1, 1, 1, 2, 2, 1, 0, 1], #[1, 2, 2, 3, 3, 2, 1, 0]]
  selected := {1, 3, 5, 7}

def e8_095 : Example 8 where
  tree := (.join (.join .edge (.join (.join .edge .edge) (.join .edge (.join .edge .edge)))) .edge)
  table := #[#[0, 1, 2, 2, 2, 2, 1, 1], #[1, 0, 1, 1, 2, 2, 1, 2], #[2, 1, 0, 1, 2, 3, 2, 3], #[2, 1, 1, 0, 1, 2, 1, 2], #[2, 2, 2, 1, 0, 1, 1, 2], #[2, 2, 3, 2, 1, 0, 1, 2], #[1, 1, 2, 1, 1, 1, 0, 1], #[1, 2, 3, 2, 2, 2, 1, 0]]
  selected := {1, 3, 5, 7}

def e8_096 : Example 8 where
  tree := (.join (.join .edge (.join (.join .edge .edge) (.join (.join .edge .edge) .edge))) .edge)
  table := #[#[0, 1, 2, 2, 3, 2, 1, 1], #[1, 0, 1, 1, 2, 2, 1, 2], #[2, 1, 0, 1, 2, 2, 2, 3], #[2, 1, 1, 0, 1, 1, 1, 2], #[3, 2, 2, 1, 0, 1, 2, 3], #[2, 2, 2, 1, 1, 0, 1, 2], #[1, 1, 2, 1, 2, 1, 0, 1], #[1, 2, 3, 2, 3, 2, 1, 0]]
  selected := {1, 3, 5, 7}

def e8_097 : Example 8 where
  tree := (.join (.join .edge (.join (.join .edge (.join .edge .edge)) (.join .edge .edge))) .edge)
  table := #[#[0, 1, 2, 3, 2, 2, 1, 1], #[1, 0, 1, 2, 1, 2, 1, 2], #[2, 1, 0, 1, 1, 2, 2, 3], #[3, 2, 1, 0, 1, 2, 2, 3], #[2, 1, 1, 1, 0, 1, 1, 2], #[2, 2, 2, 2, 1, 0, 1, 2], #[1, 1, 2, 2, 1, 1, 0, 1], #[1, 2, 3, 3, 2, 2, 1, 0]]
  selected := {1, 2, 5, 6}

def e8_098 : Example 8 where
  tree := (.join (.join .edge (.join (.join (.join .edge .edge) .edge) (.join .edge .edge))) .edge)
  table := #[#[0, 1, 2, 2, 2, 2, 1, 1], #[1, 0, 1, 1, 1, 2, 1, 2], #[2, 1, 0, 1, 2, 3, 2, 3], #[2, 1, 1, 0, 1, 2, 2, 3], #[2, 1, 2, 1, 0, 1, 1, 2], #[2, 2, 3, 2, 1, 0, 1, 2], #[1, 1, 2, 2, 1, 1, 0, 1], #[1, 2, 3, 3, 2, 2, 1, 0]]
  selected := {1, 3, 5, 6}

def e8_099 : Example 8 where
  tree := (.join (.join .edge (.join (.join .edge (.join .edge (.join .edge .edge))) .edge)) .edge)
  table := #[#[0, 1, 2, 3, 3, 2, 1, 1], #[1, 0, 1, 2, 2, 1, 1, 2], #[2, 1, 0, 1, 2, 1, 2, 3], #[3, 2, 1, 0, 1, 1, 2, 3], #[3, 2, 2, 1, 0, 1, 2, 3], #[2, 1, 1, 1, 1, 0, 1, 2], #[1, 1, 2, 2, 2, 1, 0, 1], #[1, 2, 3, 3, 3, 2, 1, 0]]
  selected := {1, 2, 4, 6}

def e8_100 : Example 8 where
  tree := (.join (.join .edge (.join (.join .edge (.join (.join .edge .edge) .edge)) .edge)) .edge)
  table := #[#[0, 1, 2, 3, 3, 2, 1, 1], #[1, 0, 1, 2, 2, 1, 1, 2], #[2, 1, 0, 1, 1, 1, 2, 3], #[3, 2, 1, 0, 1, 2, 3, 4], #[3, 2, 1, 1, 0, 1, 2, 3], #[2, 1, 1, 2, 1, 0, 1, 2], #[1, 1, 2, 3, 2, 1, 0, 1], #[1, 2, 3, 4, 3, 2, 1, 0]]
  selected := {1, 3, 4, 6}

def e8_101 : Example 8 where
  tree := (.join (.join .edge (.join (.join (.join .edge .edge) (.join .edge .edge)) .edge)) .edge)
  table := #[#[0, 1, 2, 2, 3, 2, 1, 1], #[1, 0, 1, 1, 2, 1, 1, 2], #[2, 1, 0, 1, 2, 2, 2, 3], #[2, 1, 1, 0, 1, 1, 2, 3], #[3, 2, 2, 1, 0, 1, 2, 3], #[2, 1, 2, 1, 1, 0, 1, 2], #[1, 1, 2, 2, 2, 1, 0, 1], #[1, 2, 3, 3, 3, 2, 1, 0]]
  selected := {1, 3, 4, 6}

def e8_102 : Example 8 where
  tree := (.join (.join .edge (.join (.join (.join .edge (.join .edge .edge)) .edge) .edge)) .edge)
  table := #[#[0, 1, 2, 3, 2, 2, 1, 1], #[1, 0, 1, 2, 1, 1, 1, 2], #[2, 1, 0, 1, 1, 2, 2, 3], #[3, 2, 1, 0, 1, 2, 3, 4], #[2, 1, 1, 1, 0, 1, 2, 3], #[2, 1, 2, 2, 1, 0, 1, 2], #[1, 1, 2, 3, 2, 1, 0, 1], #[1, 2, 3, 4, 3, 2, 1, 0]]
  selected := {0, 2, 4, 6}

def e8_103 : Example 8 where
  tree := (.join (.join .edge (.join (.join (.join (.join .edge .edge) .edge) .edge) .edge)) .edge)
  table := #[#[0, 1, 2, 2, 2, 2, 1, 1], #[1, 0, 1, 1, 1, 1, 1, 2], #[2, 1, 0, 1, 2, 2, 2, 3], #[2, 1, 1, 0, 1, 2, 2, 3], #[2, 1, 2, 1, 0, 1, 2, 3], #[2, 1, 2, 2, 1, 0, 1, 2], #[1, 1, 2, 2, 2, 1, 0, 1], #[1, 2, 3, 3, 3, 2, 1, 0]]
  selected := {0, 2, 4, 6}

def e8_104 : Example 8 where
  tree := (.join (.join (.join .edge .edge) (.join .edge (.join .edge (.join .edge .edge)))) .edge)
  table := #[#[0, 1, 1, 2, 2, 2, 1, 1], #[1, 0, 1, 2, 3, 3, 2, 2], #[1, 1, 0, 1, 2, 2, 1, 2], #[2, 2, 1, 0, 1, 2, 1, 2], #[2, 3, 2, 1, 0, 1, 1, 2], #[2, 3, 2, 2, 1, 0, 1, 2], #[1, 2, 1, 1, 1, 1, 0, 1], #[1, 2, 2, 2, 2, 2, 1, 0]]
  selected := {1, 3, 4, 7}

def e8_105 : Example 8 where
  tree := (.join (.join (.join .edge .edge) (.join .edge (.join (.join .edge .edge) .edge))) .edge)
  table := #[#[0, 1, 1, 2, 3, 2, 1, 1], #[1, 0, 1, 2, 3, 3, 2, 2], #[1, 1, 0, 1, 2, 2, 1, 2], #[2, 2, 1, 0, 1, 1, 1, 2], #[3, 3, 2, 1, 0, 1, 2, 3], #[2, 3, 2, 1, 1, 0, 1, 2], #[1, 2, 1, 1, 2, 1, 0, 1], #[1, 2, 2, 2, 3, 2, 1, 0]]
  selected := {1, 3, 5, 7}

def e8_106 : Example 8 where
  tree := (.join (.join (.join .edge .edge) (.join (.join .edge .edge) (.join .edge .edge))) .edge)
  table := #[#[0, 1, 1, 2, 2, 2, 1, 1], #[1, 0, 1, 2, 2, 3, 2, 2], #[1, 1, 0, 1, 1, 2, 1, 2], #[2, 2, 1, 0, 1, 2, 2, 3], #[2, 2, 1, 1, 0, 1, 1, 2], #[2, 3, 2, 2, 1, 0, 1, 2], #[1, 2, 1, 2, 1, 1, 0, 1], #[1, 2, 2, 3, 2, 2, 1, 0]]
  selected := {1, 3, 5, 7}

def e8_107 : Example 8 where
  tree := (.join (.join (.join .edge .edge) (.join (.join .edge (.join .edge .edge)) .edge)) .edge)
  table := #[#[0, 1, 1, 2, 3, 2, 1, 1], #[1, 0, 1, 2, 3, 2, 2, 2], #[1, 1, 0, 1, 2, 1, 1, 2], #[2, 2, 1, 0, 1, 1, 2, 3], #[3, 3, 2, 1, 0, 1, 2, 3], #[2, 2, 1, 1, 1, 0, 1, 2], #[1, 2, 1, 2, 2, 1, 0, 1], #[1, 2, 2, 3, 3, 2, 1, 0]]
  selected := {1, 3, 5, 7}

def e8_108 : Example 8 where
  tree := (.join (.join (.join .edge .edge) (.join (.join (.join .edge .edge) .edge) .edge)) .edge)
  table := #[#[0, 1, 1, 2, 2, 2, 1, 1], #[1, 0, 1, 2, 2, 2, 2, 2], #[1, 1, 0, 1, 1, 1, 1, 2], #[2, 2, 1, 0, 1, 2, 2, 3], #[2, 2, 1, 1, 0, 1, 2, 3], #[2, 2, 1, 2, 1, 0, 1, 2], #[1, 2, 1, 2, 2, 1, 0, 1], #[1, 2, 2, 3, 3, 2, 1, 0]]
  selected := {1, 3, 5, 7}

def e8_109 : Example 8 where
  tree := (.join (.join (.join .edge (.join .edge .edge)) (.join .edge (.join .edge .edge))) .edge)
  table := #[#[0, 1, 2, 1, 2, 2, 1, 1], #[1, 0, 1, 1, 2, 3, 2, 2], #[2, 1, 0, 1, 2, 3, 2, 3], #[1, 1, 1, 0, 1, 2, 1, 2], #[2, 2, 2, 1, 0, 1, 1, 2], #[2, 3, 3, 2, 1, 0, 1, 2], #[1, 2, 2, 1, 1, 1, 0, 1], #[1, 2, 3, 2, 2, 2, 1, 0]]
  selected := {1, 2, 4, 7}

def e8_110 : Example 8 where
  tree := (.join (.join (.join .edge (.join .edge .edge)) (.join (.join .edge .edge) .edge)) .edge)
  table := #[#[0, 1, 2, 1, 2, 2, 1, 1], #[1, 0, 1, 1, 2, 2, 2, 2], #[2, 1, 0, 1, 2, 2, 2, 3], #[1, 1, 1, 0, 1, 1, 1, 2], #[2, 2, 2, 1, 0, 1, 2, 3], #[2, 2, 2, 1, 1, 0, 1, 2], #[1, 2, 2, 1, 2, 1, 0, 1], #[1, 2, 3, 2, 3, 2, 1, 0]]
  selected := {1, 2, 4, 6}

def e8_111 : Example 8 where
  tree := (.join (.join (.join (.join .edge .edge) .edge) (.join .edge (.join .edge .edge))) .edge)
  table := #[#[0, 1, 1, 1, 2, 2, 1, 1], #[1, 0, 1, 2, 3, 3, 2, 2], #[1, 1, 0, 1, 2, 3, 2, 2], #[1, 2, 1, 0, 1, 2, 1, 2], #[2, 3, 2, 1, 0, 1, 1, 2], #[2, 3, 3, 2, 1, 0, 1, 2], #[1, 2, 2, 1, 1, 1, 0, 1], #[1, 2, 2, 2, 2, 2, 1, 0]]
  selected := {1, 3, 5, 7}

def e8_112 : Example 8 where
  tree := (.join (.join (.join (.join .edge .edge) .edge) (.join (.join .edge .edge) .edge)) .edge)
  table := #[#[0, 1, 1, 1, 2, 2, 1, 1], #[1, 0, 1, 2, 3, 3, 2, 2], #[1, 1, 0, 1, 2, 2, 2, 2], #[1, 2, 1, 0, 1, 1, 1, 2], #[2, 3, 2, 1, 0, 1, 2, 3], #[2, 3, 2, 1, 1, 0, 1, 2], #[1, 2, 2, 1, 2, 1, 0, 1], #[1, 2, 2, 2, 3, 2, 1, 0]]
  selected := {1, 2, 5, 7}

def e8_113 : Example 8 where
  tree := (.join (.join (.join .edge (.join .edge (.join .edge .edge))) (.join .edge .edge)) .edge)
  table := #[#[0, 1, 2, 2, 1, 2, 1, 1], #[1, 0, 1, 2, 1, 2, 2, 2], #[2, 1, 0, 1, 1, 2, 2, 3], #[2, 2, 1, 0, 1, 2, 2, 3], #[1, 1, 1, 1, 0, 1, 1, 2], #[2, 2, 2, 2, 1, 0, 1, 2], #[1, 2, 2, 2, 1, 1, 0, 1], #[1, 2, 3, 3, 2, 2, 1, 0]]
  selected := {1, 3, 5, 7}

def e8_114 : Example 8 where
  tree := (.join (.join (.join .edge (.join (.join .edge .edge) .edge)) (.join .edge .edge)) .edge)
  table := #[#[0, 1, 2, 2, 1, 2, 1, 1], #[1, 0, 1, 1, 1, 2, 2, 2], #[2, 1, 0, 1, 2, 3, 3, 3], #[2, 1, 1, 0, 1, 2, 2, 3], #[1, 1, 2, 1, 0, 1, 1, 2], #[2, 2, 3, 2, 1, 0, 1, 2], #[1, 2, 3, 2, 1, 1, 0, 1], #[1, 2, 3, 3, 2, 2, 1, 0]]
  selected := {1, 3, 5, 7}

def e8_115 : Example 8 where
  tree := (.join (.join (.join (.join .edge .edge) (.join .edge .edge)) (.join .edge .edge)) .edge)
  table := #[#[0, 1, 1, 2, 1, 2, 1, 1], #[1, 0, 1, 2, 2, 3, 2, 2], #[1, 1, 0, 1, 1, 2, 2, 2], #[2, 2, 1, 0, 1, 2, 2, 3], #[1, 2, 1, 1, 0, 1, 1, 2], #[2, 3, 2, 2, 1, 0, 1, 2], #[1, 2, 2, 2, 1, 1, 0, 1], #[1, 2, 2, 3, 2, 2, 1, 0]]
  selected := {1, 3, 5, 7}

def e8_116 : Example 8 where
  tree := (.join (.join (.join (.join .edge (.join .edge .edge)) .edge) (.join .edge .edge)) .edge)
  table := #[#[0, 1, 2, 1, 1, 2, 1, 1], #[1, 0, 1, 1, 2, 3, 2, 2], #[2, 1, 0, 1, 2, 3, 3, 3], #[1, 1, 1, 0, 1, 2, 2, 2], #[1, 2, 2, 1, 0, 1, 1, 2], #[2, 3, 3, 2, 1, 0, 1, 2], #[1, 2, 3, 2, 1, 1, 0, 1], #[1, 2, 3, 2, 2, 2, 1, 0]]
  selected := {1, 3, 5, 7}

def e8_117 : Example 8 where
  tree := (.join (.join (.join (.join (.join .edge .edge) .edge) .edge) (.join .edge .edge)) .edge)
  table := #[#[0, 1, 1, 1, 1, 2, 1, 1], #[1, 0, 1, 2, 2, 3, 2, 2], #[1, 1, 0, 1, 2, 3, 2, 2], #[1, 2, 1, 0, 1, 2, 2, 2], #[1, 2, 2, 1, 0, 1, 1, 2], #[2, 3, 3, 2, 1, 0, 1, 2], #[1, 2, 2, 2, 1, 1, 0, 1], #[1, 2, 2, 2, 2, 2, 1, 0]]
  selected := {1, 3, 5, 7}

def e8_118 : Example 8 where
  tree := (.join (.join (.join .edge (.join .edge (.join .edge (.join .edge .edge)))) .edge) .edge)
  table := #[#[0, 1, 2, 2, 2, 1, 1, 1], #[1, 0, 1, 2, 2, 1, 2, 2], #[2, 1, 0, 1, 2, 1, 2, 3], #[2, 2, 1, 0, 1, 1, 2, 3], #[2, 2, 2, 1, 0, 1, 2, 3], #[1, 1, 1, 1, 1, 0, 1, 2], #[1, 2, 2, 2, 2, 1, 0, 1], #[1, 2, 3, 3, 3, 2, 1, 0]]
  selected := {1, 2, 4, 6}

def e8_119 : Example 8 where
  tree := (.join (.join (.join .edge (.join .edge (.join (.join .edge .edge) .edge))) .edge) .edge)
  table := #[#[0, 1, 2, 3, 2, 1, 1, 1], #[1, 0, 1, 2, 2, 1, 2, 2], #[2, 1, 0, 1, 1, 1, 2, 3], #[3, 2, 1, 0, 1, 2, 3, 4], #[2, 2, 1, 1, 0, 1, 2, 3], #[1, 1, 1, 2, 1, 0, 1, 2], #[1, 2, 2, 3, 2, 1, 0, 1], #[1, 2, 3, 4, 3, 2, 1, 0]]
  selected := {1, 2, 4, 6}

def e8_120 : Example 8 where
  tree := (.join (.join (.join .edge (.join (.join .edge .edge) (.join .edge .edge))) .edge) .edge)
  table := #[#[0, 1, 2, 2, 2, 1, 1, 1], #[1, 0, 1, 1, 2, 1, 2, 2], #[2, 1, 0, 1, 2, 2, 3, 3], #[2, 1, 1, 0, 1, 1, 2, 3], #[2, 2, 2, 1, 0, 1, 2, 3], #[1, 1, 2, 1, 1, 0, 1, 2], #[1, 2, 3, 2, 2, 1, 0, 1], #[1, 2, 3, 3, 3, 2, 1, 0]]
  selected := {1, 2, 4, 7}

def e8_121 : Example 8 where
  tree := (.join (.join (.join .edge (.join (.join .edge (.join .edge .edge)) .edge)) .edge) .edge)
  table := #[#[0, 1, 2, 3, 2, 1, 1, 1], #[1, 0, 1, 2, 1, 1, 2, 2], #[2, 1, 0, 1, 1, 2, 3, 3], #[3, 2, 1, 0, 1, 2, 3, 4], #[2, 1, 1, 1, 0, 1, 2, 3], #[1, 1, 2, 2, 1, 0, 1, 2], #[1, 2, 3, 3, 2, 1, 0, 1], #[1, 2, 3, 4, 3, 2, 1, 0]]
  selected := {1, 2, 4, 7}

def e8_122 : Example 8 where
  tree := (.join (.join (.join .edge (.join (.join (.join .edge .edge) .edge) .edge)) .edge) .edge)
  table := #[#[0, 1, 2, 2, 2, 1, 1, 1], #[1, 0, 1, 1, 1, 1, 2, 2], #[2, 1, 0, 1, 2, 2, 3, 3], #[2, 1, 1, 0, 1, 2, 3, 3], #[2, 1, 2, 1, 0, 1, 2, 3], #[1, 1, 2, 2, 1, 0, 1, 2], #[1, 2, 3, 3, 2, 1, 0, 1], #[1, 2, 3, 3, 3, 2, 1, 0]]
  selected := {1, 2, 4, 7}

def e8_123 : Example 8 where
  tree := (.join (.join (.join (.join .edge .edge) (.join .edge (.join .edge .edge))) .edge) .edge)
  table := #[#[0, 1, 1, 2, 2, 1, 1, 1], #[1, 0, 1, 2, 3, 2, 2, 2], #[1, 1, 0, 1, 2, 1, 2, 2], #[2, 2, 1, 0, 1, 1, 2, 3], #[2, 3, 2, 1, 0, 1, 2, 3], #[1, 2, 1, 1, 1, 0, 1, 2], #[1, 2, 2, 2, 2, 1, 0, 1], #[1, 2, 2, 3, 3, 2, 1, 0]]
  selected := {1, 2, 5, 7}

def e8_124 : Example 8 where
  tree := (.join (.join (.join (.join .edge .edge) (.join (.join .edge .edge) .edge)) .edge) .edge)
  table := #[#[0, 1, 1, 2, 2, 1, 1, 1], #[1, 0, 1, 2, 2, 2, 2, 2], #[1, 1, 0, 1, 1, 1, 2, 2], #[2, 2, 1, 0, 1, 2, 3, 3], #[2, 2, 1, 1, 0, 1, 2, 3], #[1, 2, 1, 2, 1, 0, 1, 2], #[1, 2, 2, 3, 2, 1, 0, 1], #[1, 2, 2, 3, 3, 2, 1, 0]]
  selected := {1, 3, 4, 7}

def e8_125 : Example 8 where
  tree := (.join (.join (.join (.join .edge (.join .edge .edge)) (.join .edge .edge)) .edge) .edge)
  table := #[#[0, 1, 2, 1, 2, 1, 1, 1], #[1, 0, 1, 1, 2, 2, 2, 2], #[2, 1, 0, 1, 2, 2, 3, 3], #[1, 1, 1, 0, 1, 1, 2, 2], #[2, 2, 2, 1, 0, 1, 2, 3], #[1, 2, 2, 1, 1, 0, 1, 2], #[1, 2, 3, 2, 2, 1, 0, 1], #[1, 2, 3, 2, 3, 2, 1, 0]]
  selected := {1, 2, 4, 7}

def e8_126 : Example 8 where
  tree := (.join (.join (.join (.join (.join .edge .edge) .edge) (.join .edge .edge)) .edge) .edge)
  table := #[#[0, 1, 1, 1, 2, 1, 1, 1], #[1, 0, 1, 2, 3, 2, 2, 2], #[1, 1, 0, 1, 2, 2, 2, 2], #[1, 2, 1, 0, 1, 1, 2, 2], #[2, 3, 2, 1, 0, 1, 2, 3], #[1, 2, 2, 1, 1, 0, 1, 2], #[1, 2, 2, 2, 2, 1, 0, 1], #[1, 2, 2, 2, 3, 2, 1, 0]]
  selected := {1, 3, 5, 7}

def e8_127 : Example 8 where
  tree := (.join (.join (.join (.join .edge (.join .edge (.join .edge .edge))) .edge) .edge) .edge)
  table := #[#[0, 1, 2, 2, 1, 1, 1, 1], #[1, 0, 1, 2, 1, 2, 2, 2], #[2, 1, 0, 1, 1, 2, 3, 3], #[2, 2, 1, 0, 1, 2, 3, 3], #[1, 1, 1, 1, 0, 1, 2, 2], #[1, 2, 2, 2, 1, 0, 1, 2], #[1, 2, 3, 3, 2, 1, 0, 1], #[1, 2, 3, 3, 2, 2, 1, 0]]
  selected := {1, 3, 5, 7}

def e8_128 : Example 8 where
  tree := (.join (.join (.join (.join .edge (.join (.join .edge .edge) .edge)) .edge) .edge) .edge)
  table := #[#[0, 1, 2, 2, 1, 1, 1, 1], #[1, 0, 1, 1, 1, 2, 2, 2], #[2, 1, 0, 1, 2, 3, 3, 3], #[2, 1, 1, 0, 1, 2, 3, 3], #[1, 1, 2, 1, 0, 1, 2, 2], #[1, 2, 3, 2, 1, 0, 1, 2], #[1, 2, 3, 3, 2, 1, 0, 1], #[1, 2, 3, 3, 2, 2, 1, 0]]
  selected := {1, 3, 5, 7}

def e8_129 : Example 8 where
  tree := (.join (.join (.join (.join (.join .edge .edge) (.join .edge .edge)) .edge) .edge) .edge)
  table := #[#[0, 1, 1, 2, 1, 1, 1, 1], #[1, 0, 1, 2, 2, 2, 2, 2], #[1, 1, 0, 1, 1, 2, 2, 2], #[2, 2, 1, 0, 1, 2, 3, 3], #[1, 2, 1, 1, 0, 1, 2, 2], #[1, 2, 2, 2, 1, 0, 1, 2], #[1, 2, 2, 3, 2, 1, 0, 1], #[1, 2, 2, 3, 2, 2, 1, 0]]
  selected := {1, 3, 5, 7}

def e8_130 : Example 8 where
  tree := (.join (.join (.join (.join (.join .edge (.join .edge .edge)) .edge) .edge) .edge) .edge)
  table := #[#[0, 1, 2, 1, 1, 1, 1, 1], #[1, 0, 1, 1, 2, 2, 2, 2], #[2, 1, 0, 1, 2, 3, 3, 3], #[1, 1, 1, 0, 1, 2, 2, 2], #[1, 2, 2, 1, 0, 1, 2, 2], #[1, 2, 3, 2, 1, 0, 1, 2], #[1, 2, 3, 2, 2, 1, 0, 1], #[1, 2, 3, 2, 2, 2, 1, 0]]
  selected := {1, 3, 5, 7}

def e8_131 : Example 8 where
  tree := (.join (.join (.join (.join (.join (.join .edge .edge) .edge) .edge) .edge) .edge) .edge)
  table := #[#[0, 1, 1, 1, 1, 1, 1, 1], #[1, 0, 1, 2, 2, 2, 2, 2], #[1, 1, 0, 1, 2, 2, 2, 2], #[1, 2, 1, 0, 1, 2, 2, 2], #[1, 2, 2, 1, 0, 1, 2, 2], #[1, 2, 2, 2, 1, 0, 1, 2], #[1, 2, 2, 2, 2, 1, 0, 1], #[1, 2, 2, 2, 2, 2, 1, 0]]
  selected := {1, 3, 5, 7}

def cases8 : List (Example 8) := [
  e8_000,
  e8_001,
  e8_002,
  e8_003,
  e8_004,
  e8_005,
  e8_006,
  e8_007,
  e8_008,
  e8_009,
  e8_010,
  e8_011,
  e8_012,
  e8_013,
  e8_014,
  e8_015,
  e8_016,
  e8_017,
  e8_018,
  e8_019,
  e8_020,
  e8_021,
  e8_022,
  e8_023,
  e8_024,
  e8_025,
  e8_026,
  e8_027,
  e8_028,
  e8_029,
  e8_030,
  e8_031,
  e8_032,
  e8_033,
  e8_034,
  e8_035,
  e8_036,
  e8_037,
  e8_038,
  e8_039,
  e8_040,
  e8_041,
  e8_042,
  e8_043,
  e8_044,
  e8_045,
  e8_046,
  e8_047,
  e8_048,
  e8_049,
  e8_050,
  e8_051,
  e8_052,
  e8_053,
  e8_054,
  e8_055,
  e8_056,
  e8_057,
  e8_058,
  e8_059,
  e8_060,
  e8_061,
  e8_062,
  e8_063,
  e8_064,
  e8_065,
  e8_066,
  e8_067,
  e8_068,
  e8_069,
  e8_070,
  e8_071,
  e8_072,
  e8_073,
  e8_074,
  e8_075,
  e8_076,
  e8_077,
  e8_078,
  e8_079,
  e8_080,
  e8_081,
  e8_082,
  e8_083,
  e8_084,
  e8_085,
  e8_086,
  e8_087,
  e8_088,
  e8_089,
  e8_090,
  e8_091,
  e8_092,
  e8_093,
  e8_094,
  e8_095,
  e8_096,
  e8_097,
  e8_098,
  e8_099,
  e8_100,
  e8_101,
  e8_102,
  e8_103,
  e8_104,
  e8_105,
  e8_106,
  e8_107,
  e8_108,
  e8_109,
  e8_110,
  e8_111,
  e8_112,
  e8_113,
  e8_114,
  e8_115,
  e8_116,
  e8_117,
  e8_118,
  e8_119,
  e8_120,
  e8_121,
  e8_122,
  e8_123,
  e8_124,
  e8_125,
  e8_126,
  e8_127,
  e8_128,
  e8_129,
  e8_130,
  e8_131]

end MopFTMD.Data
