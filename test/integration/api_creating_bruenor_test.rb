require "test_helper"
require "dice"

class ApiCreatingBruenorTest < ActionDispatch::IntegrationTest
  using Distance::Refinements
  
  ActiveSupport::TestCase.test_order = :alpha
  @@creation = CharacterCreation.new
  
  def creation
    @@creation
  end
  
  def bruenor
    creation.character
  end
  
  test "1. Choosing a race" do
    creation.choose_race(Races::MountainDwarf).take(:smiths_tools) # TODO: it would probably to nice to have something like: +creation.choose_race Races::MountainDwarf, picking: :smiths_tools+
    
    assert_kind_of Races::MountainDwarf, bruenor
    assert_equal 25.feet, bruenor.speed
    assert_includes bruenor.languages, :common
    assert_includes bruenor.languages, :dwarvish
    assert bruenor.proficient_with?(:smiths_tools)
  end
  
  test "2. Choosing a class" do
    creation.choose_character_class CharacterClasses::Fighter
    
    assert_equal 1, bruenor.level
    assert_equal Dice("1d10"), bruenor.hit_dice
    assert_equal 10 + bruenor.constitution_modifier, bruenor.hit_points
    assert_equal +2, bruenor.proficiency_bonus
    assert bruenor.proficient_with?(:light_armor)
    assert bruenor.proficient_with?(:medium_armor)
    assert bruenor.proficient_with?(:heavy_armor)
    assert bruenor.proficient_with?(:shields)
    assert bruenor.proficient_with?(:simple_weapons)
    assert bruenor.proficient_with?(:martial_weapons)
    assert bruenor.proficient_in?(:strength_saving_throw)
    assert bruenor.proficient_in?(:constitution_saving_throw)
  end

  test "3. Determining ability scores" do
    creation.assign_ability_score(:strength, 15)
    creation.assign_ability_score(:dexterity, 10)
    creation.assign_ability_score(:constitution, 14)
    creation.assign_ability_score(:intelligence, 8)
    creation.assign_ability_score(:wisdom, 13)
    creation.assign_ability_score(:charisma, 12)
    
    assert_equal "17 (+3)", bruenor.strength.to_s
    assert_equal "10 (+0)", bruenor.dexterity.to_s
    assert_equal "16 (+3)", bruenor.constitution.to_s
    assert_equal "8 (-1)", bruenor.intelligence.to_s
    assert_equal "13 (+1)", bruenor.wisdom.to_s
    assert_equal "12 (+1)", bruenor.charisma.to_s
  end

  test "4. Describing the character" do
    skip "Backgrounds aren't implemented yet"
    
    creation.choose_name "Bruenor"
    creation.choose_sex :male
    creation.choose_alignment :lawful_good
    creation.choose_height :random
    creation.choose_weight :random
    creation.choose_personality_trait "I am a caring, sensitive dwarf who genuinely loves his friends and allies."
    creation.choose_personality_trait "I hide this soft heart behind a gruff, snarling demeanor."
    creation.choose_ideal "Fairness"
    creation.choose_bond "Someday reclaiming Mithral Hall, my homeland, from the shadow dragon that drove the dwarves out."
    creation.choose_flaw "I have a soft spot for orphans and wayward souls, leading me to show mercy even when it might not be warranted."
    creation.choose_background(Backgrounds::FolkHero).take(:cartographers_tools)
    
    assert_equal "Bruenor", bruenor.name
    assert bruenor.male?
    assert bruenor.lawful_good?
    refute_nil bruenor.height
    refute_nil bruenor.weight
    assert_include bruenor.personality_traits, "I am a caring, sensitive dwarf who genuinely loves his friends and allies."
    assert_include bruenor.personality_traits, "I hide this soft heart behind a gruff, snarling demeanor."
    assert_include bruenor.ideals, "Fairness"
    assert_include bruenor.bonds, "Someday reclaiming Mithral Hall, my homeland, from the shadow dragon that drove the dwarves out."
    assert_include bruenor.flaws, "I have a soft spot for orphans and wayward souls, leading me to show mercy even when it might not be warranted."
    assert bruenor.proficient_in?(:animal_handling)
    assert bruenor.proficient_in?(:survival)
    assert bruenor.proficient_in?(:cartographers_tools)
  end

  test "5. Choosing equipment" do
    skip
  end
end
