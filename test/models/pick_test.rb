require "test_helper"

class PickTest < ActiveSupport::TestCase
  test "A Pick is defined by the number of items to take, and the list from which they can be chosen" do
    pick = Pick.new(count: 1, list: [:adventure, :boar])
    
    assert_equal 1, pick.count
    assert_includes pick.list, :adventure
    assert_includes pick.list, :boar
  end
  
  test "A Pick cannot have a count higher than the length of its list" do
    assert_raises(ArgumentError) { Pick.new(count: 3, list: [:campaign, :death]) }
  end
  
  test "Picks can be unavailable" do
    pick = Pick.new count:1, list: [:travel, :unarmed]
    pick.unavailable!
    
    refute pick.available?
  end
  
  test "Nothing can be picked if the pick is not available" do
    pick = Pick.new count: 1, list: [:necromancy, :orc]
    pick.unavailable!
    
    assert_raises(StandardError) { pick.take :orc }
  end
  
  test "Unavailable picks can be initialized directly" do
    pick = Pick.unavailable count: 1, list: [:penalty, :quick_build]
    
    assert_kind_of Pick, pick
    refute pick.available?
  end
  
  test "Copying an unavailable pick creates an available copy" do
    unavailable = Pick.unavailable count: 1, list: [:resting, :sage]
    
    pick = unavailable.dup
    
    assert_equal 1, pick.count
    assert_equal [:resting, :sage], pick.list
    assert pick.available?
  end
  
  test "Picked items can be retrieved" do
    pick = Pick.new count: 2, list: [:effect, :familiar, :gender]
    
    pick.take(:familiar)
    
    assert_equal [:familiar], pick.picked_items
  end
  
  test "A pick is not done until as many items as necessary have been taken" do
    pick = Pick.new count: 2, list: [:hawk, :initiative, :jumping]
    
    pick.take(:jumping)
    refute pick.done?
    pick.take(:hawk)
    assert pick.done?
  end
  
  test "Only items from the list can be taken" do
    pick = Pick.new count: 1, list: [:knight, :level, :mastiff]
    
    assert_raises(ArgumentError) { pick.take :lodging }
  end
  
  
  test "Item are ignored when picked several times" do
    pick = Pick.new count: 2, list: [:vision, :wealth]
    
    pick.take :vision
    pick.take :vision
    
    assert_equal [:vision], pick.picked_items
    refute pick.done?
  end
end
