class Codex < DelegateClass(Set)
  class_attribute :groups, instance_writer: false
  
  def initialize(*values)
    @set = Set.new values, &:to_sym
    super(@set)
  end
  
  def <<(o)
    super o.to_sym
  end
  alias_method :add, :<<

  def include?(o)
    super o.to_sym
  end

  def expand
    Codex.new(*@set.map { |entry| groups.fetch(entry, [entry]) }.flatten)
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
        super @codex_class.new(*value)
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
