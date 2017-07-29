module CharacterClasses
  Paladin = CharacterClass.new(
    hit_die_type: :d10,
    proficiencies: [:light_armor, :medium_armor, :heavy_armor, :shields,
                    :simple_weapons, :martial_weapons,
                    :wisdom_saving_throw, :charisma_saving_throw,
                    Pick.choose(2, from: [:athletics, :insight, :intimidation, :medicine, :persuasion, :religion])]
  )
end
