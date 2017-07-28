class Codex < DelegateClass(SetWithIndifferentAccess)
  class_attribute :groups, instance_writer: false
  
  def self.[](*values)
    new(values)
  end
  
  def self.pick(count, from: )
    Pick.new(count: count, list: from)
  end
  
  def initialize(set_or_values = nil)
    @set = if set_or_values.is_a?(SetWithIndifferentAccess)
             set_or_values
           else
             SetWithIndifferentAccess.new(set_or_values)
           end
    super(@set)
  end
  
  def include?(o)
    expanded_set.include? o
  end

  def expand
    Codex.new(expanded_set)
  end
  
  private def expanded_set
    if groups.present?
      SetWithIndifferentAccess.new @set.flat_map { |entry| groups.with_indifferent_access.fetch(entry, []) << entry }
    else
      @set
    end
  end
  
  class Pick
    attr_reader :count, :list
    
    def initialize(count:, list:)
      raise ArgumentError, "Cannot pick #{count} items from a list of #{list.count}" if count > list.count
      
      @count, @list = count, list
    end
  end
  
  class Type < ActiveRecord::Type::Value
    def initialize(codex_class = Codex, **kwargs)
      raise ArgumentError, "#{codex_class} is not a valid Codex" unless codex_class <= Codex
      
      @codex_class = codex_class
      super(**kwargs)
    end
    
    def cast(value)
      if value.kind_of? @codex_class
        super
      else
        super @codex_class.new(value)
      end
    end
    
    def changed_in_place?(raw_old_value, new_value)
      deserialize(raw_old_value) != new_value
    end
    
    def serialize(codex)
      codex.to_a
    end
  end
end
