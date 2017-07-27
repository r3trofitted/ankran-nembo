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
  
  test "#hit_point_maximum is the sum of the base hit points plus the constitution modifier" do
    conan = Character.new base_hit_points: 10, constitution: 12 # hit point maximum: 10 (base) + 1 (constitution modifier) = 11
    
    assert_equal 11, conan.hit_point_maximum
  end
  
  test "#hit_points is equal to the hit point maximum minus the lost hit points" do
    conan = Character.new base_hit_points: 10, constitution: 12 # hit point maximum: 10 (base) + 1 (constitution modifier) = 11
    
    assert_equal 11, conan.hit_points
    
    conan.lost_hit_points = 8
    assert_equal 3, conan.hit_points
  end
  
  test "#proficiency_bonus depends on the character's level" do
    bonus_table = {
       1 => +2,  2 => +2,  3 => +2,  4 => +2,
       5 => +3,  6 => +3,  7 => +3,  8 => +3,
       9 => +4, 10 => +4, 11 => +4, 12 => +4,
      13 => +5, 14 => +5, 15 => +5, 16 => +5,
      17 => +6, 18 => +6, 19 => +6, 20 => +6
    }
    
    bonus_table.each do |level, bonus|
      assert_equal bonus, Character.new(level: level).proficiency_bonus
    end
  end
  
  test "#proficient_in? returns true if the character has the right proficiency" do
    fafhrd = Character.new(proficiencies: [:simple_weapons, :greatsword, :performance])
    
    assert fafhrd.proficient_in? :greatsword
    assert fafhrd.proficient_in? :dagger # value from the +:simple_weapons+ proficiencies group
    refute fafhrd.proficient_in? :insight
  end
  
  test "#proficient_in? accepts a string or a symbol" do
    fafhrd = Character.new(proficiencies: [:greatsword, :performance])
    
    assert fafhrd.proficient_in? "greatsword"
  end
  
  test "Proficiencies and languages can be gained" do
    bilbo = Character.new
    
    bilbo.gain_language :elvish
    assert_includes bilbo.languages, :elvish
    
    bilbo.gain_proficiency :stealth, "sleight_of_hand" # works with both symbols and strings
    assert_includes bilbo.proficiencies, :stealth
    assert_includes bilbo.proficiencies, :sleight_of_hand
  end
  
  test "Abilities can be altered" do
    moonglum = Character.new(constitution: 12)
    
    moonglum.alter_ability :constitution, by: 2
    
    assert_equal 14, moonglum.constitution.score
  end
  
  test "A character has abilities modifiers" do
    the_grey_mouser = Character.new
    
    assert_respond_to the_grey_mouser, :strength_modifier
    assert_respond_to the_grey_mouser, :dexterity_modifier
    assert_respond_to the_grey_mouser, :constitution_modifier
    assert_respond_to the_grey_mouser, :intelligence_modifier
    assert_respond_to the_grey_mouser, :wisdom_modifier
    assert_respond_to the_grey_mouser, :charisma_modifier
  end
end
