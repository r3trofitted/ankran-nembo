class Pick
  attr_reader :count, :list, :picked_items
  
  def self.choose(count, from:)
    self.new(count: count, list: from).tap(&:make_template!)
  end
  
  def initialize(count:, list:)
    raise ArgumentError, "Cannot choose #{count} items from a list of #{list.count}" if count > list.count
    
    @count, @list = count, list
    @picked_items = []
  end
  
  def make_template!
    @_template = true
  end
  
  def template?
    @_template ||= false
  end
  
  def take(*items)
    raise StandardError, "Cannot take item from a template Pick" if template?
    raise ArgumentError, "Only items from the list can be taken (invalid items: #{(items - list)})" if (items - list).any?
    
    @picked_items.concat(items).uniq!
    resume_context if done?
  end
  
  def done?
    @picked_items.count == count
  end
  
  def initialize_copy(original)
    super
    @_template = false
  end
  
  def in_context(context)
    dup.tap { |p| p.add_context(context) }
  end
  
  protected def add_context(fiber)
    raise StandardError, "Cannot add a context to a template Pick" if template?
    
    @_context = fiber
  end
  
  private def resume_context
    @_context.resume(picked_items) if @_context
  end
end
