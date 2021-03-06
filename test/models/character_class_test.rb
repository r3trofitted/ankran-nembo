require "test_helper"
require "dice"

class CharacterClassTest < ActiveSupport::TestCase
  test "by default, a CharacterClass has a die type of :d8" do
    assert_equal :d8, CharacterClass.new.hit_die_type
  end
  
  test "when extending a Character, a CharacterClass redefines its `#hit_dice`" do
    fighter = CharacterClass.new hit_die_type: :d10
    fafhrd = Character.new level: 3
    
    refute_equal Dice("3d10"), fafhrd.hit_dice
    fafhrd.extend(fighter)
    assert_equal Dice("3d10"), fafhrd.hit_dice
  end
  
  test "A CharacterClass can have Pick objects for proficiencies" do
    miner = CharacterClass.new proficiencies: [Pick.choose(3, from: [:dig, :shovel, :drill])]
    
    assert_kind_of Pick, miner.proficiencies.first
  end
end
