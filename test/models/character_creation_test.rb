require "test_helper"

class CharacterCreationTest < ActiveSupport::TestCase
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
  
  test "When a race with mandatory proficiencies pick is chosen, a Pick object is returned" do
    creation = CharacterCreation.new
    race     = Race.new proficiencies: [Pick.choose(1, from: [:gummy_bear, :lollipop])]
    
    assert_kind_of Pick, creation.choose_race(race)
  end
  
  test "When a race with picks is chosen, the picked values are added to the Character, but the picks themselves are not" do
    creation = CharacterCreation.new
    race = Race.new proficiencies: [:mms, Pick.choose(1, from: [:skittles, :toffee])]
    
    creation.choose_race(race).take(:toffee)
    
    assert_includes creation.character.proficiencies, :mms
    assert_includes creation.character.proficiencies, :toffee
    assert creation.character.proficiencies.none? { |p| p.is_a? Pick }
  end
  
  test "When a race with mandatory proficiencies picks is chosen, the choice is defered until the proficiencies are picked" do
    creation = CharacterCreation.new
    race = Race.new proficiencies: [Pick.choose(1, from: [:liquorice, :chewing_gum])]
    
    pick = creation.choose_race(race)
    assert_nil creation.character.race # character class is not set yet
    
    pick.take(:liquorice)
    refute_nil creation.character.race # character class is eventually set
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
  
  test "The character's name can be chosen" do
    creation = CharacterCreation.new
    creation.choose_name "Gandalf"
    assert_equal "Gandalf", creation.character.name
  end
  
  test "The character's sex can be chosen, but invalid values are rejected" do
    creation = CharacterCreation.new
    
    creation.choose_sex :female
    assert creation.character.female?
    
    assert_raises(ArgumentError) { creation.choose_sex :average }
  end
  
  test "The character's alignment can be chosen, but invalid values are rejected" do
    creation = CharacterCreation.new
    
    creation.choose_alignment :neutral
    assert creation.character.neutral?
    
    assert_raises(ArgumentError) { creation.choose_alignment :vertical }
  end
  
  test "The alignment can be chosen outside of the normal alignments for the character's race" do
    creation = CharacterCreation.new
    race     = Race.new alignments: %i(lawful_evil neutral_evil chaotic_evil)
    creation.choose_race race
    
    creation.choose_alignment :chaotic_good
    
    assert creation.character.chaotic_good?
  end
  
  test "The character's height can be chosen" do
    skip "we'll need smarter Distances for this one"
  end
  
  test "The character's height can be set at random, but only if the character's race is already assigned" do
    skip "we'll need smarter Distances for this one"
  end
  
  test "The character's weight can be chosen" do
  end
  
  test "The character's weight can be set at random, but only if the character's race is already assigned" do
  end
  
  test "The character's personnality traits can be chosen" do
    creation = CharacterCreation.new
    
    creation.choose_personnality_trait "I was, in fact, raised by wolves."
    creation.choose_personnality_trait "Nothing can shake my optimistic attitude."
    
    assert_includes creation.character.personnality_traits, "I was, in fact, raised by wolves."
    assert_includes creation.character.personnality_traits, "Nothing can shake my optimistic attitude."
  end
  
  test "Once the character has two personnality traits, subsequent choices replace the previous traits" do
    creation = CharacterCreation.new
    creation.choose_personnality_trait "Flattery is my preferred trick for getting what I want."
    creation.choose_personnality_trait "I pocket anything I see that might have some value."
    
    creation.choose_personnality_trait "I blow up at the slightest insult."
    
    refute_includes creation.character.personnality_traits, "Flattery is my preferred trick for getting what I want."
    assert_includes creation.character.personnality_traits, "I pocket anything I see that might have some value."
    assert_includes creation.character.personnality_traits, "I blow up at the slightest insult."
  end
  
  test "The character's personnality traits can be set at random, but only if the character's background is already assigned" do
    skip "Backgrounds aren't implemented yet"
    
    creation = CharacterCreation.new
    
    assert_raises(ArgumentError) { creation.choose_personnality_trait :random }
    
    creation.choose_background Backgrounds::Sailor
    creation.choose_ideal(:random)
    refute_empty creation.personnality_traits.ideals
  end
  
  test "A given personnality trait cannot be set twice at random" do
  end
  
  test "The character's ideal can be chosen" do
    creation = CharacterCreation.new
    creation.choose_ideal "Power. Knowledge is the path to power and domination."
    assert_includes creation.character.ideals, "Power. Knowledge is the path to power and domination."
  end
  
  test "The character's ideal can be set at random, but only if the character's background is already assigned" do
    skip "Backgrounds aren't implemented yet"
    
    creation = CharacterCreation.new
    
    assert_raises(ArgumentError) { creation.choose_ideal :random }
    
    creation.choose_background Backgrounds::Sailor
    creation.choose_ideal(:random)
    refute_empty creation.character.ideals
  end
  
  test "The character's bond can be chosen" do
    creation = CharacterCreation.new
    creation.choose_bond "Those who fight beside me are those worth dying for."
    assert_includes creation.character.bonds, "Those who fight beside me are those worth dying for."
  end
  
  test "The character's bond can be set at random, but only if the character's background is already assigned" do
    skip "Backgrounds aren't implemented yet"
    
    creation = CharacterCreation.new
    
    assert_raises(ArgumentError) { creation.choose_bond :random }
    
    creation.choose_background Backgrounds::Sailor
    creation.choose_bond(:random)
    refute_empty creation.character.bonds
  end
  
  test "The character's flaw can be chosen" do
    creation = CharacterCreation.new
    creation.choose_bond "It’s not stealing if I need it more than someone else."
    assert_includes creation.character.bonds, "It’s not stealing if I need it more than someone else."
  end
  
  test "The character's flaw can be set at random, but only if the character's background is already assigned" do
    skip "Backgrounds aren't implemented yet"
    
    creation = CharacterCreation.new
    
    assert_raises(ArgumentError) { creation.choose_flaw :random }
    
    creation.choose_background Backgrounds::Sailor
    creation.choose_flaw(:random)
    refute_empty creation.character.flaws
  end
  
  test "The character's background can be chosen" do
    skip "Backgrounds aren't implemented yet"
  end
  
  test "When a background is chosen, its two proficiencies are added to the Character" do
    skip "Backgrounds aren't implemented yet"
  end
  
  test "When a background with mandatory proficiencies pick is chosen, a Pick object is returned" do
    skip "Backgrounds aren't implemented yet"
  end
  
  test "When a background with picks is chosen, the picked values are added to the Character, but the picks themselves are not" do
    skip "Backgrounds aren't implemented yet"
  end
end
