require "test_helper"

class CharacterClasses::BarbarianTest < ActiveSupport::TestCase
  test "The Barbarians' hit die is a d12" do
    assert_equal :d12, CharacterClasses::Barbarian.hit_die_type
  end

  test "Barbarians have proficiency in all light and medium armors, shields, and simple and martial weapons" do
    assert_includes CharacterClasses::Barbarian.proficiencies, :light_armor
    assert_includes CharacterClasses::Barbarian.proficiencies, :medium_armor
    assert_includes CharacterClasses::Barbarian.proficiencies, :simple_weapons
    assert_includes CharacterClasses::Barbarian.proficiencies, :martial_weapons
  end

  test "Barbarians have proficiency in strength and constitution saving throws" do
    assert_includes CharacterClasses::Barbarian.proficiencies, :strength_saving_throw
    assert_includes CharacterClasses::Barbarian.proficiencies, :constitution_saving_throw
  end
end
