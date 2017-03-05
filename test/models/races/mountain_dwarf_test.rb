require "test_helper"

class Races::MountainDwarfTest < ActiveSupport::TestCase
  using Distance::Refinements
  
  test "Mountain Dwarves have a Strength score increase of 2" do
    assert_equal 2, Races::MountainDwarf.ability_score_increases[:strength]
  end

  test "Mountain Dwarves have proficiency in light armor and medium armor" do
    assert_includes Races::MountainDwarf.proficiencies, :light_armor
    assert_includes Races::MountainDwarf.proficiencies, :medium_armor
  end
end
