class Character < ApplicationRecord
  using Distance::Refinements
  
  cattr_reader :abilities, instance_reader: false do
    %i(strength dexterity constitution intelligence wisdom charisma)
  end
  
  abilities.each { |ability| attribute ability, :ability }
  attribute :proficiencies, Codex::Type.new(ProficienciesSet)
  attribute :languages, Codex::Type.new(LanguagesSet)
  serialize :armor
  
  def darkvision
    0.feet
  end
  
  def speed
    base_speed - (armor&.speed_penalty(self) || 0)
  end
  
  private
  
  def base_speed
    30.feet
  end
end
