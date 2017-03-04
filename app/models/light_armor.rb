class LightArmor < Armor
  def ac(wearer)
    @base_ac + wearer.dexterity.modifier
  end
end
