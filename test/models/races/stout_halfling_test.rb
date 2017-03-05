require "test_helper"

class Races::StoutHalflingTest < ActiveSupport::TestCase
  using Distance::Refinements
  
  test "Stouts have a Constitution score increase of 1" do
    assert_equal 1, Races::StoutHalfling.ability_score_increases[:constitution]
  end
end
