module Races
  MountainDwarf = Dwarf.subrace(
    ability_score_increases: { strength: +2 },
    proficiencies: [:light_armor, :medium_armor]
  )
end
