require "test_helper"

class CharacterClasses::BardTest < ActiveSupport::TestCase
  test "The Bards' hit die is a d10" do
    assert_equal :d8, CharacterClasses::Bard.hit_die_type
  end

  test "Bards have proficiency in light armors, simple weapons, hand crossbows, longsword, rapier and shortsword" do
    assert_includes CharacterClasses::Bard.proficiencies, :light_armor
    assert_includes CharacterClasses::Bard.proficiencies, :simple_weapons
    assert_includes CharacterClasses::Bard.proficiencies, :hand_crossbow
    assert_includes CharacterClasses::Bard.proficiencies, :longsword
    assert_includes CharacterClasses::Bard.proficiencies, :rapier
    assert_includes CharacterClasses::Bard.proficiencies, :shortsword
  end

  test "Bards have proficiency in dexterity and charisma saving throws" do
    assert_includes CharacterClasses::Bard.proficiencies, :dexterity_saving_throw
    assert_includes CharacterClasses::Bard.proficiencies, :charisma_saving_throw
  end
end
