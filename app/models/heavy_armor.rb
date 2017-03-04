class HeavyArmor < Armor
  using Distance::Refinements
  
  def initialize(ac, str: nil, **kwargs)
    @str = str
    kwargs[:penalises_stealth] ||= true
    super(ac, kwargs)
  end
  
  def required_strength
    @str
  end
  
  def speed_penalty(wearer)
    10.feet if @str&.> wearer.strength.score
  end
end
