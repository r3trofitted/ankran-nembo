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
  
  test "When a character class is chosen, the Character's base hit points are correctly set" do
    creation = CharacterCreation.new
    character_class = CharacterClass.new hit_die_type: :d20
    
    creation.choose_character_class character_class
    
    assert_equal 20, creation.character.base_hit_points
  end
  
  test "When a character class is chosen, its proficiencies are added to the Character" do
    creation = CharacterCreation.new
    character_class = CharacterClass.new proficiencies: [:cooking, :grooming]
    
    creation.choose_character_class character_class
    
    assert_includes creation.character.proficiencies, :cooking
    assert_includes creation.character.proficiencies, :grooming
  end
  
  test "When a character class with mandatory proficiencies pick is chosen, a Pick object is returned" do
    creation = CharacterCreation.new
    character_class = CharacterClass.new proficiencies: [Pick.choose(2, from: [:ale, :beer, :cider])]
    
    assert_kind_of Pick, creation.choose_character_class(character_class)
  end
  
  test "When a character class with picks is chosen, the picked values are added to the Character, but the picks themselves are not" do
    creation = CharacterCreation.new
    character_class = CharacterClass.new proficiencies: [:red, Pick.choose(1, from: [:white, :rosé])]
    
    creation.choose_character_class(character_class).take(:white)
    
    assert_includes creation.character.proficiencies, :red
    assert_includes creation.character.proficiencies, :white
    assert creation.character.proficiencies.none? { |p| p.is_a? Pick }
  end
  
  test "When a character class with mandatory proficiencies picks is chosen, the choice is defered until the proficiencies are picked" do
    creation = CharacterCreation.new
    character_class = CharacterClass.new proficiencies: [Pick.choose(2, from: [:ale, :beer, :cider])]
    
    pick = creation.choose_character_class(character_class)
    assert_nil creation.character.character_class # character class is not set yet
    
    pick.take(:ale, :cider)
    refute_nil creation.character.character_class # character class is eventually set
  end
  
  test "When ability scores are assigned, the racial increases are preserved" do
    creation = CharacterCreation.new
    race     = Race.new ability_score_increases: { dexterity: 1 }
    creation.choose_race race
    
    assert_equal 1, creation.character.dexterity.score
    
    creation.assign_ability_score :dexterity, 15
    assert_equal 16, creation.character.dexterity.score # 15 + 1
  end
end
