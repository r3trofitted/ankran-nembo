require "test_helper"

class HeavyArmorTest < ActiveSupport::TestCase
  using Distance::Refinements
  
  test "by default, heavy armors penalises stealth" do
    armor = HeavyArmor.new(16, str: 13)
    assert armor.penalises_stealth?
  end
  
  test "a heavy armor can still *not* penalise stealth" do
    magic_armor = HeavyArmor.new(17, str: 11, penalises_stealth: false)
    refute magic_armor.penalises_stealth?
  end
  
  test "a heavy armor can impose a speed penalty if its wearer's strength isn't high enough" do
    armor = HeavyArmor.new(14, str: 13)
    
    assert_equal 10.feet, armor.speed_penalty(Character.new(strength: 10))
    assert_nil armor.speed_penalty(Character.new(strength: 13))
  end
end
