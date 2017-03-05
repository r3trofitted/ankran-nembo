require "test_helper"

class Races::DwarfTest < ActiveSupport::TestCase
  using Distance::Refinements
  
  test "Dwarves have a Constitution score increase of 2" do
    assert_equal 2, Races::Dwarf.ability_score_increases[:constitution]
  end
  
  test "Dwarves have a base speed of 25 feet" do
    assert_equal 25.feet, Races::Dwarf.speed
  end

  test "Dwarves have darkvision up to 60 feet" do
    assert_equal 60.feet, Races::Dwarf.darkvision
  end

  test "Dwarves have proficiency with the battleaxe, handaxe, light hammer and warhammer" do
    assert_includes Races::Dwarf.proficiencies, :battleaxe
    assert_includes Races::Dwarf.proficiencies, :handaxe
    assert_includes Races::Dwarf.proficiencies, :light_hammer
    assert_includes Races::Dwarf.proficiencies, :warhammer
  end

  test "Dwarves speak Common and Dwarvish" do
    assert_includes Races::Dwarf.languages, :common
    assert_includes Races::Dwarf.languages, :dwarvish
  end

  test "A Dwarf's base base speed is not reduced when wearing a heavy armor" do
    gloin = Character.new(race: Races::Dwarf, strength: 10)
    gloin.armor = HeavyArmor.new(strength: 15)

    assert_equal Races::Dwarf.speed, gloin.speed
  end
end
