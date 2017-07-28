class Choice
  attr_reader :count, :list, :chosen_items
  
  def initialize(count:, list:)
    raise ArgumentError, "Cannot choose #{count} items from a list of #{list.count}" if count > list.count
    
    @count, @list = count, list
    @chosen_items = []
  end
  
  def choose(item)
    raise ArgumentError, "#{item} is not in the list" unless item.in? list
    
    @chosen_items << item
  end
  
  def done?
    @chosen_items.count == count
  end
end
