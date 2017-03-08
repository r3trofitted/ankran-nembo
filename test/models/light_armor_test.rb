require "test_helper"

class LightArmorTest < ActiveSupport::TestCase
  test "the AC is modified by the wearer's Dexterity modifier" do
    armor = LightArmor.new(12)
    character = Character.new(dexterity: 20) # modifier: +5
    
    assert_equal 17, armor.ac(character)
  end
end
