module CharacterClasses
  Fighter = CharacterClass.new(
    hit_die_type: :d10,
        proficiencies: [:light_armor, :medium_armor, :heavy_armor, :shields,
                        :simple_weapons, :martial_weapons,
                        :strength_saving_throw, :constitution_saving_throw]
  )
end
