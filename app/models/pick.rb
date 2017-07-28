class Pick
  attr_reader :count, :list, :picked_items
  
  def self.unavailable(**kwargs)
    self.new(**kwargs).tap { |p| p.unavailable! }
  end
  
  def initialize(count:, list:)
    raise ArgumentError, "Cannot choose #{count} items from a list of #{list.count}" if count > list.count
    
    @count, @list = count, list
    @picked_items = []
    @_available    = true
  end
  
  def unavailable!
    @_available = false
  end
  
  def available?
    @_available
  end
  
  def take(item)
    raise ArgumentError, "#{item} is not in the list" unless item.in? list
    raise StandardError, "Cannont take item from an unavailable Pick" unless available?
    
    @picked_items << item
  end
  
  def done?
    @picked_items.count == count
  end
  
  def initialize_copy(original)
    super
    @_available = true
  end
end
