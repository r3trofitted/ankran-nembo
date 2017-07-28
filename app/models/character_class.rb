class CharacterClass < Module
  def initialize(hit_die_type: :d8, proficiencies: [], &block)
    self.hit_die_type  = hit_die_type
    self.proficiencies = proficiencies
    super(&block)
  end
  
  def hit_die_type
    @hit_die_type
  end
  
  def hit_die_type=(value)
    @hit_die_type = value
    define_method(:hit_dice) { Dice.new level, value }
  end
  
  def proficiencies
    @proficiences
  end
  
  def proficiencies=(value)
    @proficiences = value
  end
  
  def picks
    @proficiences.select { |p| Pick === p }
  end
end
