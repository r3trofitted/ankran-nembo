module Races
  using Distance::Refinements
  
  Elf = Race.new(
    ability_score_increases: { dexterity: 2 },
    speed: 30.feet,
    darkvision: 60.feet,
    proficiencies: [:perception],
    languages: [:common, :elvish]
  )
end
