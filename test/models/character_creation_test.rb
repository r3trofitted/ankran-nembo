require "test_helper"

class CharacterCreationTest < ActiveSupport::TestCase
  test "#character returns the Character being created" do
    creation = CharacterCreation.new name: "Fafhrd"
    
    character = creation.character
    
    assert_kind_of Character, character
    assert_equal "Fafhrd", character.name
  end
  
  test "Characters are created at 1st level" do
    creation = CharacterCreation.new
    assert_equal 1, creation.character.level
  end
  
  test "When a race is chosen, its languages and proficiencies are added to the Character" do
    creation = CharacterCreation.new
    race     = Race.new languages: [:daemonic], proficiencies: [:invocation]
    
    creation.choose_race race
    
    assert_includes creation.character.languages, :daemonic
    assert_includes creation.character.proficiencies, :invocation
  end
  
  test "When a race is chosen, the Character's ability score are increased accordingly" do
    creation = CharacterCreation.new
    race     = Race.new ability_score_increases: { charisma: 2 }
    
    creation.choose_race race
    
    assert_equal 2, creation.character.charisma.score
  end
end
