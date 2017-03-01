class Distance
  include Comparable
  
  attr_reader :length
  
  def initialize(length)
    @length = length.to_f
    freeze
  end
  
  def +(other)
    case other
    when Distance
      Distance.new(length + other.length)
    when 0, nil
      self
    else
      raise TypeError
    end
  end
  
  def -(other)
    case other
    when Distance
      Distance.new([0, length - other.length].max)
    when 0, nil
      self
    else
      raise TypeError
    end
  end
  
  def *(other)
    raise TypeError, "Can't multiply two Distances" if other.is_a? Distance
    Distance.new(length * other.to_f)
  end
  
  def /(other)
    if other.is_a? Distance
      (length / other.length).to_i
    else
      Distance.new(length / other)
    end
  end
  
  def ==(other)
    Distance(other).length == length
  end
  
  def <=>(other)
    self.length <=> other.length
  end
  
  def to_f
    length
  end
  
  def to_i
    length.to_i
  end
  
  def to_s
    "%.2g\u{00A0}ft" % length
  end
  
  module Refinements
    refine Numeric do
      def feet
        Distance(self)
      end
      alias :foot :feet
    end
  end
end

module Kernel
  def Distance(other)
    if other.is_a? Distance
      other
    else
      Distance.new(Float(other))
    end
  end
  module_function :Distance
end
