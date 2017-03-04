class MediumArmor < Armor
  def ac(wearer)
    @base_ac + [wearer.dexterity.modifier, 2].min
  end
end
