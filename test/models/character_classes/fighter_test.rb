require "test_helper"

class CharacterClasses::FighterTest < ActiveSupport::TestCase
  test "The Fighters' hit die is a d10" do
    assert_equal :d10, CharacterClasses::Fighter.hit_die_type
  end

  test "Fighters have proficiency in all armors, shields, simple weapons and martial weapons" do
    assert_includes CharacterClasses::Fighter.proficiencies, :light_armor
    assert_includes CharacterClasses::Fighter.proficiencies, :medium_armor
    assert_includes CharacterClasses::Fighter.proficiencies, :heavy_armor
    assert_includes CharacterClasses::Fighter.proficiencies, :simple_weapons
    assert_includes CharacterClasses::Fighter.proficiencies, :martial_weapons
  end

  test "Fighters have proficiency in strength and constitution saving throws" do
    assert_includes CharacterClasses::Fighter.proficiencies, :strength_saving_throw
    assert_includes CharacterClasses::Fighter.proficiencies, :constitution_saving_throw
  end
end
