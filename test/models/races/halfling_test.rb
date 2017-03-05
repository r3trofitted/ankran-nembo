require "test_helper"

class Races::HalflingTest < ActiveSupport::TestCase
  using Distance::Refinements
  
  test "Halflings have a Dexterity score increase of 2" do
    assert_equal 2, Races::Halfling.ability_score_increases[:dexterity]
  end

  test "Halflings have a base speed of 25 feet" do
    assert_equal 25.feet, Races::Halfling.speed
  end

  test "Halflings speak Common and Halfling" do
    assert_includes Races::Halfling.languages, :common
    assert_includes Races::Halfling.languages, :halfling
  end
end
