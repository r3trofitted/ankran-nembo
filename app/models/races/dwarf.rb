module Races
  using Distance::Refinements
  
  Dwarf = Race.new(
    ability_score_increases: { constitution: 2 },
    speed: 25.feet,
    darkvision: 60.feet,
    proficiencies: [:battleaxe, :handaxe, :light_hammer, :warhammer],
    languages: [:common, :dwarvish]
  ) do
    private
    
    def armor_speed_penalty
      armor.is_a?(HeavyArmor) ? 0 : super
    end
  end
end
