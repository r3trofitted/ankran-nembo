class CharacterClass < Module
    self.hit_die_type = hit_die_type
  def initialize(hit_die_type: :d8, &block)
    super(&block)
  end
  
  def hit_die_type
    @hit_die_type
  end
  
  def hit_die_type=(value)
    @hit_die_type = value
    define_method(:hit_dice) { Dice.new level, value }
  end
end
