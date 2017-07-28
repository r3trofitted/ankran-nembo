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
    resume_context if done?
  end
  
  def done?
    @picked_items.count == count
  end
  
  def initialize_copy(original)
    super
    @_available = true
  end
  
  def in_context(context)
    dup.tap { |p| p.add_context(context) }
  end
  
  protected def add_context(fiber)
    raise StandardError, "Cannot add a context to an unavailable Pick" unless available?
    
    @_context = fiber
  end
  
  private def resume_context
    @_context.resume(picked_items) if @_context
  end
end
