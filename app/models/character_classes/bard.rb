module CharacterClasses
  Bard = CharacterClass.new(
    hit_die_type: :d8,
    proficiencies: [:light_armor,
                    :simple_weapons, :hand_crossbow, :longsword, :rapier, :shortsword,
                    Pick.choose(3, from: [:artisans_tools, :diguise_kit, :forgery_kit, :gaming_set]),
                    Pick.choose(3, from: [:athletics, :acrobatics, :sleight_of_hand, :stealth]),
                    :dexterity_saving_throw, :charisma_saving_throw]
  )
end
