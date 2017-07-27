require "test_helper"

class AbilityTest < ActiveSupport::TestCase
  test "the correct modifier is returned for each score from 1 to 30" do
    modifiers_table = {
       1 => -5,  2 => -4,  3 => -4,  4 => -3,  5 => -3,  6 => -2,  7 => -2,  8 => -1,  9 => -1, 10 =>  0,
      11 =>  0, 12 => +1, 13 => +1, 14 => +2, 15 => +2, 16 => +3, 17 => +3, 18 => +4, 19 => +4, 20 => +5,
      21 => +5, 22 => +6, 23 => +6, 24 => +7, 25 => +7, 26 => +8, 27 => +8, 28 => +9, 29 => +9, 30 => +10
    }
    
    modifiers_table.each do |score, modifier|
      assert_equal modifier, Ability.new(score).modifier
    end
  end
  
  test "the string representation of an ability show the score and the modifier" do
    assert_equal "17 (+3)", Ability.new(17).to_s
    assert_equal "3 (-4)", Ability.new(3).to_s
  end
end
