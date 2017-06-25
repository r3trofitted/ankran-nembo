class Dice
  attr_reader :count, :sides, :modifier
  
  def self.parse(rep)
    if /(?<count>\d+)[dD](?<sides>\d+)\s*(?<modifier>[+-]\d+)?/ =~ rep.remove(/\s/)
      new count, sides: sides, modifier: modifier
    else
      raise ArgumentError, "#{rep} is not a valid dice representation"
    end
  end
  
  def initialize(count = 1, type = :d6, sides: sides_from_type(type), modifier: 0)
    @count, @sides, @modifier = count.to_i, sides.to_i, modifier.to_i
  end
  
  def roll!(random = Random)
    Roll.new Array.new(@count) { random.rand(1..@sides) }, modifier: @modifier
  end
  
  def ==(other)
    [count, sides, modifier] == [other.count, other.sides, other.modifier]
  end
  
  def sides_from_type(type)
    type[/(?<=d)\d+/i]
  end

  class Roll < DelegateClass(Integer)
    def initialize(dice_scores, modifier: 0)
      @dice_scores = Array(dice_scores)
      @modifier    = modifier
      super(total)
      freeze
    end
    
    def total
      @dice_scores.sum + @modifier
    end
    
    def inspect
      "#<#{self.class} scores: #{@dice_scores * ', '}, modifier: #{'%+d' % @modifier}>"
    end
  end
end

module Kernel
  def Dice(other)
    if other.is_a? Dice
      other
    else
      Dice.parse(other)
    end
  end
  module_function :Dice
end
