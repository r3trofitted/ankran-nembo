require "test_helper"

class Races::HillDwarfTest < ActiveSupport::TestCase
  using Distance::Refinements
  
  test "Hill Dwarves have a Wisdom score increase of 1" do
    assert_equal 1, Races::HillDwarf.ability_score_increases[:wisdom]
  end
end
