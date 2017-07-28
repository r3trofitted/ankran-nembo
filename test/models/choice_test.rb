require "test_helper"

class ChoiceTest < ActiveSupport::TestCase
  test "A Choice is defined by the number of items to choose, and the list from which they can be chosen" do
    choice = Choice.new(count: 1, list: [:adventure, :boar])
    
    assert_equal 1, choice.count
    assert_includes choice.list, :adventure
    assert_includes choice.list, :boar
  end
  
  test "A Choice cannot have a count higher than the length of its list" do
    assert_raises(ArgumentError) { Choice.new(count: 3, list: [:campaign, :death]) }
  end
  
  test "Chosen items can be retrieved" do
    choice = Choice.new count: 2, list: [:effect, :familiar, :gender]
    
    choice.choose(:familiar)
    
    assert_equal [:familiar], choice.chosen_items
  end
  
  test "A choice is not done until as many items as necessary have been chosen" do
    choice = Choice.new count: 2, list: [:hawk, :initiative, :jumping]
    
    choice.choose(:jumping)
    refute choice.done?
    choice.choose(:hawk)
    assert choice.done?
  end
  
  test "Only items from the list can be chosen" do
    choice = Choice.new count: 1, list: [:knight, :level, :mastiff]
    
    assert_raises(ArgumentError) { choice.choose :lodging }
  end
end
