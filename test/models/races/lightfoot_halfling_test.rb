require "test_helper"

class Races::LightfootHalflingTest < ActiveSupport::TestCase
  using Distance::Refinements
  
  test "Lightfeet have a Charisma score increase of 1" do
    assert_equal 1, Races::LightfootHalfling.ability_score_increases[:charisma]
  end
end
