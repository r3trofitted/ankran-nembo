require "test_helper"

class Races::HumanTest < ActiveSupport::TestCase
  using Distance::Refinements
  
  test "Humans have a Strength score increase of 1" do
    assert_equal 1, Races::Human.ability_score_increases[:strength]
  end
  
  test "Humans have a Dexterity score increase of 1" do
    assert_equal 1, Races::Human.ability_score_increases[:dexterity]
  end
  
  test "Humans have a Constitution score increase of 1" do
    assert_equal 1, Races::Human.ability_score_increases[:constitution]
  end
  
  test "Humans have an Intelligence score increase of 1" do
    assert_equal 1, Races::Human.ability_score_increases[:intelligence]
  end
  
  test "Humans have a Wisdom score increase of 1" do
    assert_equal 1, Races::Human.ability_score_increases[:wisdom]
  end
  
  test "Humans have a Charisma score increase of 1" do
    assert_equal 1, Races::Human.ability_score_increases[:charisma]
  end
  
  test "Humans have a base speed of 30 feet" do
    assert_equal 30.feet, Races::Human.speed
  end
  
  test "Humans have no darkvision" do
    assert_equal 0, Races::Human.darkvision
  end
end
