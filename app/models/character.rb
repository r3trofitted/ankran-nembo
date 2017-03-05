class Character < ApplicationRecord
  using Distance::Refinements
  
  cattr_reader :abilities, instance_reader: false do
    %i(strength dexterity constitution intelligence wisdom charisma)
  end
  
  abilities.each { |ability| attribute ability, :ability }
  attribute :proficiencies, Codex::Type.new(ProficienciesSet)
  attribute :languages, Codex::Type.new(LanguagesSet)
  serialize :armor
  
  def race=(race)
    super
    extend(race)
  end
  
  def darkvision
    0.feet
  end
  
  def speed
    base_speed - armor_speed_penalty
  end
  
  def base_speed
    30.feet
  end
  
  def gain_language(*language_or_languages)
    languages.merge language_or_languages
  end
  
  def gain_proficiency(*proficiency_or_proficiencies)
    proficiencies.merge proficiency_or_proficiencies
  end
  
  private
  
  def armor_speed_penalty
    armor&.speed_penalty(self) || 0
  end
end
