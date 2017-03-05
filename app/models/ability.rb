class Ability
  attr_reader :score
  
  def initialize(score)
    @score = score
  end
  
  def modifier
    ((score - 10) / 2).floor
  end
  
  def +(other)
    Ability.new(score + other)
  end
  alias_method :add, :+
  
  class Type < ActiveRecord::Type::Value
    def cast(value)
      if value.kind_of? Ability
        super(value)
      else
        super(Ability.new(value.to_i))
      end
    end
  
    def serialize(value)
      value.score
    end
  end
end
