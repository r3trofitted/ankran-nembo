require "test_helper"

class MediumArmorTest < ActiveSupport::TestCase
  test "A medium armor's AC is modified by the wearer's Dexterity modifier, capped at 2" do
    armor = MediumArmor.new(13)
    character = Character.new(dexterity: 20) # modifier: +5
    
    assert_equal 15, armor.ac(character)
  end
end
