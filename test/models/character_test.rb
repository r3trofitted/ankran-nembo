require "test_helper"

class CharacterTest < ActiveSupport::TestCase
  using Distance::Refinements
  
  test "#race=: assigning the character's race extends the character with the race" do
    conan    = Character.new
    cimerian = Race.new
    
    conan.race = cimerian
    
    assert_kind_of cimerian, conan
  end
  
  test "#character_class=: assigning the character's class extends the character with the character class" do
    sparhawk       = Character.new
    pandion_knight = CharacterClass.new
    
    sparhawk.character_class = pandion_knight
    
    assert_kind_of pandion_knight, sparhawk
  end
  
  test "#darkvision: by default, a character has no darkvision" do
    assert_equal 0.feet, Character.new.darkvision
  end
    
  test "#speed: by default, a character has a speed of 30 feet" do
    assert_equal 30.feet, Character.new.speed
  end
  
  test "#speed: a character's speed can be reduced by her armor" do
    red_sonja = Character.new(armor: Object.new)
    
    red_sonja.armor.define_singleton_method(:speed_penalty) { |_| 10.feet }
    
    assert_equal 20.feet, red_sonja.speed # 30′ (default) - 10′ (penalty) = 20′
  end
  
  test "#hit_dice: by default, a character has a hit dice of 1d8" do
    assert_equal Dice.new(1, sides:8), Character.new.hit_dice
  end
  
  test "Proficiencies and languages can be gained" do
    bilbo = Character.new
    
    bilbo.gain_language :elvish
    assert_includes bilbo.languages, :elvish
    
    bilbo.gain_proficiency :stealth, :sleight_of_hand
    assert_includes bilbo.proficiencies, :stealth
    assert_includes bilbo.proficiencies, :sleight_of_hand
  end
  
  test "Abilities can be altered" do
    moonglum = Character.new(constitution: 12)
    
    moonglum.alter_ability :constitution, by: 2
    
    assert_equal 14, moonglum.constitution.score
  end
end
