class CharacterCreation < ApplicationRecord
  def character
    @character ||= Character.new(name: name, level: 1)
  end
  
  def choose_race(race)
    character.tap do |c|
      c.race = race
      c.gain_language(*race.languages)
      c.gain_proficiency(*race.proficiencies)
      race.ability_score_increases.each { |name, amount| c.alter_ability name, by: amount }
    end
  end
  
  def choose_character_class(character_class)
    choice_in_progress = Fiber.new do
      character_class.picks.each do |pick|
        picked_proficiencies = Fiber.yield pick.in_context(choice_in_progress)
        character.gain_proficiency *picked_proficiencies
      end
      
      character.character_class = character_class
      character.base_hit_points = Dice.new(1, character_class.hit_die_type).max
      character.gain_proficiency(*character_class.proficiencies)
      
      character
    end
    
    choice_in_progress.resume
  end
  
  def assign_ability_score(ability, score)
    character[ability] += score
  end
end
