module Races
  using Distance::Refinements
  
  Human = Race.new(
    ability_score_increases: Character.abilities.product([1]).to_h,
    speed: 30.feet,
    darkvision: 0
  )
end
