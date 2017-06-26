##
# A Dice represents a die or group of dice to be rolled
#
# Even though a single die can sometimes be rolled (eg. a d20 when making an attack roll), 
# it is quite common to roll several dice at once, optionnaly adding or substracting 
# a modifier, and still treat the whole as a single “die”, as in “this +1 greatsword makes 
# 2d8 + 1 damage”. This is the kind of “dice” that +Dice+ represents.
#
# (For more details on dice rolls, check the Player's Handbook, p.6.)
#
# There are three commom ways to create a +Dice+ object. The first is the normal initializer, the 
# second is the Dice.parse method, and the third is the Kernel.Dice conversion function.
#
#   Dice.new(3, sides: 6, modifier: 3)
#   Dice.new(3, :d6, modifier: 3)
#   Dice.parse("3d6 + 3")
#   Dice("3d6 + 3")

class Dice
  attr_reader :count, :sides, :modifier
  
  # Returns a +Dice+ object from a dice notation, eg. <tt>2d10 + 2</tt>
  def self.parse(notation)
    if /(?<count>\d+)[dD](?<sides>\d+)\s*(?<modifier>[+-]\d+)?/ =~ notation.remove(/\s/)
      new count, sides: sides, modifier: modifier
    else
      raise ArgumentError, "#{notation} is not a valid dice notation"
    end
  end
  
  # Creates a new +Dice+ instance. The dice type (ie. its number of sides) can be specified
  # either by passing a symbol as the second argument (eg. +:d10+) or through the
  # keyword argument +sides:+
  def initialize(count = 1, type = :d6, sides: sides_from_type(type), modifier: 0)
    @count, @sides, @modifier = count.to_i, sides.to_i, modifier.to_i
  end
  
  # Rolls the dice once and returns the result as a Dice::Roll instance
  def roll!(random = Random)
    Roll.new Array.new(@count) { random.rand(1..@sides) }, modifier: @modifier
  end
  
  # Two instances of Dice are considered equal if they have the same count, sides and modifier
  def ==(other)
    [count, sides, modifier] == [other.count, other.sides, other.modifier]
  end
  
  # :nodoc:
  def sides_from_type(type)
    type[/(?<=d)\d+/i]
  end

  # A Dice::Roll represents the _results_ of a dice roll. It can be used as
  # an Integer in most cases (ie. additions, comparisons, etc.), but retains
  # the details of each die's score.
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
    
    # :nodoc:
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
