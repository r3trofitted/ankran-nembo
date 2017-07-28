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
  
  def take(*items)
    raise StandardError, "Cannot take item from an unavailable Pick" unless available?
    raise ArgumentError, "Only items from the list can be taken (invalid items: #{(items - list)})" if (items - list).any?
    
    @picked_items.concat(items).uniq!
  end
  
  def done?
    @picked_items.count == count
  end
  
  def initialize_copy(original)
    super
    @_available = true
  end
end
