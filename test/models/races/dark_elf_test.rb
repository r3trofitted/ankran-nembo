require "test_helper"

class Races::DarkElfTest < ActiveSupport::TestCase
  using Distance::Refinements
  
  test "Dark Elves have a Charisma score increased of 1" do
    assert_equal 1, Races::DarkElf.ability_score_increases[:charisma]
  end
  
  test "Dark Elves have darkvision up to 120 feet" do
    assert_equal 120.feet, Races::DarkElf.darkvision
  end
  
  test "Dark Elves have proficiency with the rapiers, shortswords, hand crossbows" do
    assert_includes Races::DarkElf.proficiencies, :rapier
    assert_includes Races::DarkElf.proficiencies, :shortsword
    assert_includes Races::DarkElf.proficiencies, :hand_crossbow
  end
end
