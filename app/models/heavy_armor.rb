class HeavyArmor < Armor
  using Distance::Refinements
  
  def initialize(ac, penalises_stealth: true, str: nil)
    @str = str
    super ac, penalises_stealth: penalises_stealth
  end
  
  def required_strength
    @str
  end
  
  def speed_penalty(wearer)
    10.feet if @str&.> wearer.strength.score
  end
end
