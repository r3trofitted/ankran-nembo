class Race < Module
  using Distance::Refinements
  
  CORE_TRAITS = %i(ability_score_increases speed darkvision languages proficiencies).freeze
  
  def initialize(**definition, &block)
    traits = definition.extract!(*CORE_TRAITS)
    traits.each { |trait, value| public_send "#{trait}=", value }
    
    if @original_race = definition.delete(:subrace_of)
      singleton_class.prepend SubraceRules
    end
    
    super(&block)
  end
  
  def subrace(**definition, &block)
    Race.new(**definition.merge(subrace_of: self), &block)
  end
  
  def speed
    @speed
  end
  
  def speed=(value)
    @speed = value
    define_method(:base_speed) { value }
  end
  
  def darkvision
    @darkvision
  end
  
  def darkvision=(value)
    @darkvision = value
    define_method(:darkvision) { value }
  end
  
  def ability_score_increases
    @ability_score_increases || {}
  end
  
  def ability_score_increases=(value)
    @ability_score_increases = value
  end
  
  def proficiencies
    @proficiences || []
  end
  
  def proficiencies=(value)
    @proficiences = value
  end
  
  def languages
    @languages || []
  end
  
  def languages=(value)
    @languages = value
  end
  
  concern :SubraceRules do
    attr_reader :original_race
    
    def extend_object(o)
      o.extend @original_race
      super(o)
    end
    
    def ability_score_increases
      super.merge(@original_race.ability_score_increases) { |_, a, b| a + b }
    end
    
    def languages
      super | @original_race.languages
    end
    
    def proficiencies
      super | @original_race.proficiencies
    end
  end
end
