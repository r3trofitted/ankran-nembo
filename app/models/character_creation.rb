class CharacterCreation < ApplicationRecord
  def character
    @character ||= Character.new(name: name, level: 1)
  end
  
  def choose_race(race)
    assigning_proficiencies(race.proficiencies) do
      character.race = race
      character.gain_language(*race.languages)
      race.ability_score_increases.each { |name, amount| character.alter_ability name, by: amount }
    end
  end
  
  def choose_character_class(character_class)
    assigning_proficiencies(character_class.proficiencies) do
      character.character_class = character_class
      character.base_hit_points = Dice.new(1, character_class.hit_die_type).max
    end
  end
  
  def assign_ability_score(ability, score)
    character[ability] += score
  end
  
  private
  
  # Handles the assignement of proficiencies when applying other treatments to the character 
  # (such as choosing a race or a character class).
  #
  # When assigning proficiencies (from a race or a character class), it may be necessary to
  # require picking values from a list. (Eg. “choose two weapons from the martial weapons category”.)
  # Proficiencies cannot be assigned until all picks are done, and in turn, the normal treatment should
  # not be applied until all proficiencies are assigned.
  #
  # This method accepts two arguments: a collection of proficiencies (including optional picks)
  # and a block; the latter is executed once all the proficiencies are assigned.
  # The return value is either a +Pick+ (when picks are required) or the character itself (when 
  # executing the block)
  def assigning_proficiencies(proficiencies)
    picks, other_proficiencies = proficiencies.partition { |p| p.is_a? Pick }
    
    choice_in_progress = Fiber.new do
      picks.each do |pick|
        taken_proficiencies = Fiber.yield pick.in_context(choice_in_progress)
        character.gain_proficiency *taken_proficiencies
      end
      character.gain_proficiency(*other_proficiencies)
      
      yield
      
      character
    end
    
    choice_in_progress.resume
  end
end
