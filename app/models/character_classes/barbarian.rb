module CharacterClasses
  Barbarian = CharacterClass.new(
    hit_die_type: :d12,
    proficiencies: [:light_armor, :medium_armor, :shields,
                    :simple_weapons, :martial_weapons,
                    :strength_saving_throw, :constitution_saving_throw]
  )
end
