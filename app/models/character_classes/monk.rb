module CharacterClasses
  Monk = CharacterClass.new(
    hit_die_type: :d8,
    proficiencies: [:simple_weapons, :shortsword,
                    # Pick.choose(1, from: Tool.artisans_tools + Tool.musical_instruments),
                    :strength_saving_throw, :dexterity_saving_throw,
                    Pick.choose(2, from: [:acrobatics, :athletics, :history, :insight, :religion, :stealth])]
  )
end
