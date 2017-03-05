require "test_helper"

class Races::WoodElfTest < ActiveSupport::TestCase
  using Distance::Refinements
  
  test "Wood Elfves have a Wisdom score increase of 1" do
    assert_equal 1, Races::WoodElf.ability_score_increases[:wisdom]
  end
  
  test "Wood Elves have a base speed of 35 feet" do
    assert_equal 35.feet, Races::WoodElf.speed
  end
  
  test "Wood Elves have proficiency with the longsword, shortsword, shortbow and longbow" do
    assert_includes Races::WoodElf.proficiencies, :longsword
    assert_includes Races::WoodElf.proficiencies, :shortsword
    assert_includes Races::WoodElf.proficiencies, :shortbow
    assert_includes Races::WoodElf.proficiencies, :longbow
  end
end
