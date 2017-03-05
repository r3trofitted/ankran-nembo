module Races
  using Distance::Refinements
    
  Halfling = Race.new(
    ability_score_increases: { dexterity: 2 },
    speed: 25.feet,
    languages: [:common, :halfling]
  )
end
