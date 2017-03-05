require 'test_helper'

class CharacterTest < ActiveSupport::TestCase
  using Distance::Refinements
  
  test "#race=: assigning the character's race extends the character with the race" do
    conan    = Character.new
    cimerian = Race.new
    
    conan.race = cimerian
    
    assert_kind_of cimerian, conan
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
end