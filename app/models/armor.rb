class Armor
  using Distance::Refinements
  
  attr_reader :penalises_stealth
  alias_method :penalises_stealth?, :penalises_stealth
  
  def initialize(base_ac, penalises_stealth: false)
    @base_ac, @penalises_stealth = base_ac, penalises_stealth
  end
  
  def ac(_wearer)
    @base_ac
  end
  
  def speed_penalty(_wearer)
    nil
  end
end
