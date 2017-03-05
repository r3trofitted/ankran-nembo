module Races
  HighElf = Elf.subrace(
    ability_score_increases: { intelligence: 1 },
    proficiencies: %i(longsword shortsword shortbow longbow)
  )
end
