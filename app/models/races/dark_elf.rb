module Races
  using Distance::Refinements
  
  DarkElf = Elf.subrace(
    ability_score_increases: { charisma: 1 },
    darkvision: 120.feet,
    proficiencies: %i(rapier shortsword hand_crossbow)
  )
end
