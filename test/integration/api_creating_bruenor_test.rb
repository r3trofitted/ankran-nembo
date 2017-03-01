require "test_helper"
require "dice"

class ApiCreatingBruenorTest < ActionDispatch::IntegrationTest
  using Distance::Refinements
  
  ActiveSupport::TestCase.test_order = :alpha
  
  def setup
    @bruenor = Character.new
  end
  
  test "1. Choosing a race" do
    @bruenor.race = Races::MountainDwarf
    
    assert_kind_of Races::MountainDwarf, @bruenor
    assert_equal 25.feet, @bruenor.speed
    assert_equal [:common, :dwarvish], @bruenor.languages
    assert_includes @bruenor.languages, :common
    assert_includes @bruenor.languages, :dwarvish
  end
  
  test "2. Choosing a class" do
    skip
    
    @bruenor.character_class = CharacterClasses::Fighter
    
    assert_equal 1, @bruenor.level
    assert_equal Dice("1d10"), @bruenor.hit_dice
    assert_equal 10 + @bruenor.constitution_modifier, @bruenor.hit_points
    assert_equal +2, @bruenor.proficiency_bonus
  end

  test "3. Determining ability scores" do
    skip
    
    @bruenor.assign_ability_score(:strength, 15)
    @bruenor.assign_ability_score(:dexterity, 10)
    @bruenor.assign_ability_score(:constitution, 14)
    @bruenor.assign_ability_score(:intelligence, 8)
    @bruenor.assign_ability_score(:wisdom, 13)
    @bruenor.assign_ability_score(:charisma, 12)
    
    assert_equal "17 (+3)", @bruenor.strength.to_s
    assert_equal "10 (+0)", @bruenor.dexterity.to_s
    assert_equal "16 (+3)", @bruenor.constitution.to_s
    assert_equal "8 (-1)", @bruenor.intelligence.to_s
    assert_equal "13 (+1)", @bruenor.wisdom.to_s
    assert_equal "12 (+1)", @bruenor.charsima.to_s
  end

  test "4. Describing the character" do
    skip
  end

  test "5. Choosing equipment" do
    skip
  end
end
