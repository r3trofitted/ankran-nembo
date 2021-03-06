require "test_helper"
require "fiber"

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
  
  test "Picks can be templates" do
    pick = Pick.new count:1, list: [:travel, :unarmed]
    pick.make_template!
    
    assert pick.template?
  end
  
  test "Nothing can be picked if the pick is a template" do
    pick = Pick.new count: 1, list: [:necromancy, :orc]
    pick.make_template!
    
    assert_raises(StandardError) { pick.take :orc }
  end
  
  test "Unavailable picks can be initialized directly" do
    pick = Pick.choose 1, from: [:penalty, :quick_build]
    
    assert_kind_of Pick, pick
    assert pick.template?
  end
  
  test "Copying a template pick creates a non-template copy" do
    template = Pick.choose 1, from: [:resting, :sage]
    
    pick = template.dup
    
    assert_equal 1, pick.count
    assert_equal [:resting, :sage], pick.list
    refute pick.template?
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
  
  test "Picks with a context can be created from an template Pick" do
    template = Pick.choose 1, from: [:abjuration, :blindsight]
    
    pick = template.in_context(Fiber.new{})
    
    assert_equal 1, pick.count
    assert_equal [:abjuration, :blindsight], pick.list
    refute_nil pick.instance_variable_get(:@_context)
  end
  
  test "When done, a pick resumes its context" do
    context = Fiber.new { pass "context correctly resumed" }
    pick    = Pick.choose(1, from: [:xp, :ysgard]).in_context(context)
    
    assert context.alive?
    pick.take :xp
    refute context.alive?
  end
end
