class Character < ApplicationRecord
  using Distance::Refinements
  
  cattr_reader :abilities, instance_reader: false do
    %i(strength dexterity constitution intelligence wisdom charisma)
  end
  
  attribute :proficiencies, Codex::Type.new(ProficienciesSet)
  attribute :languages, Codex::Type.new(LanguagesSet)
  serialize :armor
  
  abilities.each do |ability|
    attribute ability, :ability
    delegate :modifier, to: ability, prefix: true
  end
  
  def race=(race)
    super
    extend(race)
  end
  
  def character_class=(character_class)
    super
    extend(character_class)
  end
  
  def darkvision
    0.feet
  end
  
  def speed
    base_speed - armor_speed_penalty
  end
  
  def hit_dice
    Dice.new(sides: 8)
  end
  
  def hit_point_maximum
    base_hit_points + constitution_modifier
  end
  
  def hit_points
    hit_point_maximum - lost_hit_points
  end
  
  def proficiency_bonus
    level.fdiv(4).ceil + 1 # formula based on the Character Advancement table, PHB p.15
  end
  
  def base_speed
    30.feet
  end
  
  def alter_ability(name, by:)
    raise ArgumentError, "#{name} is not a valid Ability" unless name.in? Character.abilities
    
    public_send "#{name}=", public_send(name).add(by)
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
