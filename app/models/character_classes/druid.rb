module CharacterClasses
  Druid = CharacterClass.new(
    hit_die_type: :d8,
    proficiencies: [:light_armor, :medium_armor, :shields,
                    :club, :dagger, :dart, :javelin, :mace, :quarterstaff, :scimitar, :sickle, :sling, :spear,
                    :herbalism_kit,
                    :intelligence_saving_throw, :wisdom_saving_throw,
                    Pick.choose(2, from: [:arcana, :animal_handling, :insight, :medicine, :nature, :perception, :religion, :survival])]
  )
end
