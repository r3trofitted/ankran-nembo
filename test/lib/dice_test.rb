require "test_helper"
require 'minitest/mock'

class DiceTest < ActiveSupport::TestCase
  test "a Dice object can represent a pool of several dice" do
    dice = Dice.new(3)
    assert_equal 3, dice.count
  end
  
  test "a Dice object has a default pool of 1 die" do
    assert_equal 1, Dice.new.count
  end
  
  test "the sides of the dice in the pool can be set" do
    dice = Dice.new(2, sides: 10)
    assert_equal 10, dice.sides
  end
  
  test "the sides of the dice in the pool can be set with a :dX notation instead of a sides: keyword argument" do
    dice = Dice.new(1, :d20)
    assert_equal 20, dice.sides
  end
  
  test "by default, the dice in the pool have 6 sides" do
    assert_equal 6, Dice.new.sides
  end
  
  test "a modifier can be applied to the roll" do
    assert_equal -3, Dice.new(modifier: -3).modifier
  end
  
  test "by default, a roll has no modifier" do
    assert_equal 0, Dice.new.modifier
  end
  
  test "two Dice objects are equal if they have the same pool size, sides and modifiers" do
    assert_equal Dice.new(1, sides: 10, modifier: +2), Dice.new(1, sides: 10, modifier: +2)
  end
  
  test "#roll! generates as many random numbers as necessary, each one between 1 and the number of sides" do
    mock_random = Minitest::Mock.new
    mock_random.expect(:rand, 4, [1..8]) # first die
    mock_random.expect(:rand, 5, [1..8]) # second die
    
    Dice.new(2, sides: 8).roll!(mock_random)
    
    mock_random.verify
  end
  
  test "#roll! returns a Dice::Roll object" do
    assert_kind_of Dice::Roll, Dice.new.roll!
  end
  
  test ".parse creates a Dice object from a string representation" do
    dice = Dice.parse("1d10")
    
    assert_kind_of Dice, dice
    assert_equal 1, dice.count
    assert_equal 10, dice.sides
  end
  
  test ".parse recognises modifiers as well" do
    assert_equal 3, Dice.parse("1d6 + 3").modifier
    assert_equal -1, Dice.parse("1d6 - 1").modifier
  end
  
  test ".parse doesn't trip on whitespaces" do
    dice = Dice.parse "1  d 12 +  3"
    
    assert_equal 1, dice.count
    assert_equal 12, dice.sides
    assert_equal 3, dice.modifier
  end
  
  test ".parse raises an error if the representation is invalid" do
    assert_raises(ArgumentError) { Dice.parse "lorem ipsum" }
  end
  
  test "a Dice::Roll#inspect is quite helpful, thank you very much" do
    assert_equal "#<Dice::Roll scores: 2, 7, 4, modifier: +2>", Dice::Roll.new([2, 7, 4], modifier: 2).inspect
  end
  
  test "Dice::Roll#total returns the total of the rolls plus the modifier" do
    assert_equal 9, Dice::Roll.new([3, 3, 4], modifier: -1).total
  end
  
  test "a Dice::Roll object supports arithmetic operations" do
    roll = Dice::Roll.new([1,3])
    
    assert_equal 6, roll + 2
    assert_equal 0, roll - 4
    assert_equal 2, roll / 2
    assert_equal 6, roll * 1.5
  end
  
  test "a Dice::Roll object can be used in arithmetic operations" do
    roll = Dice::Roll.new(12)
    
    assert_equal 14, 2 + roll
    assert_equal 2, 14 - roll
    assert_equal 30, 2.5 * roll
    assert_equal 1, 12 / roll
  end
  
  test "a Dice::Roll object is immutable" do
    assert_raises(RuntimeError) { Dice::Roll.new([3, 6]).instance_variable_set(:@dice_scores, [2]) }
  end
end
