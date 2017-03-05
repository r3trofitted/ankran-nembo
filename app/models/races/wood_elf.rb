module Races
  using Distance::Refinements
    
  WoodElf = Elf.subrace(
    ability_score_increases: { wisdom: 1 },
    speed: 35.feet,
    proficiencies: %i(longsword shortsword shortbow longbow)
  )
end
