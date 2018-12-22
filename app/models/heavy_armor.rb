class HeavyArmor < Armor
  using Distance::Refinements
  
  def initialize(ac, str: nil, **kwargs)
    @str = str
    super ac, kwargs.with_defaults(penalises_stealth: true)
  end
  
  def required_strength
    @str
  end
  
  def speed_penalty(wearer)
    10.feet if @str&.> wearer.strength.score
  end
end
