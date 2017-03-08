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
end
