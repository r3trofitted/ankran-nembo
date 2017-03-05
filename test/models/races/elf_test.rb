require "test_helper"

class Races::ElfTest < ActiveSupport::TestCase
  using Distance::Refinements
  
  test "Elves have a Dexterity score increase of 2" do
    assert_equal 2, Races::Elf.ability_score_increases[:dexterity]
  end

  test "Elves have a base speed of 30 feet" do
    assert_equal 30.feet, Races::Elf.speed
  end

  test "Elves have darkvision up to 60 feet" do
    assert_equal 60.feet, Races::Elf.darkvision
  end

  test "Elves have proficiency in perception" do
    assert_includes Races::Elf.proficiencies, :perception
  end

  test "Elves speak Common and Elvish" do
    assert_includes Races::Elf.languages, :common
    assert_includes Races::Elf.languages, :elvish
  end
end
