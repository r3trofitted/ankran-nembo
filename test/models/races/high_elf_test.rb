require "test_helper"

class Races::HighElfTest < ActiveSupport::TestCase
  using Distance::Refinements
  
  test "High Elves have an Intelligence score increase of 1" do
    assert_equal 1, Races::HighElf.ability_score_increases[:intelligence]
  end
  
  test "High Elves have proficiency with the longsword, shortsword, shortbow and longbow" do
    assert_includes Races::HighElf.proficiencies, :longsword
    assert_includes Races::HighElf.proficiencies, :shortsword
    assert_includes Races::HighElf.proficiencies, :shortbow
    assert_includes Races::HighElf.proficiencies, :longbow
  end
end
