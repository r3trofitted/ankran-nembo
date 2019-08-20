module CharacterClasses
  Cleric = CharacterClass.new(
    hit_die_type: :d8,
    proficiencies: [:light_armor, :medium_armor,
                    :simple_weapons,
                    :wisdom_saving_throw, :charisma_saving_throw,
                    Pick.choose(2, from: [:history, :insight, :medicine, :persuasion, :religion])]
  )
end
