require "test_helper"

class RaceTest < ActiveSupport::TestCase
  using Distance::Refinements
  
  test "by default, a Race has no speed" do
    assert_nil Race.new.speed
  end
  
  test "by default, a Race has no darkvision" do
    assert_nil Race.new.darkvision
  end
  
  test "by default, a Race provides no ability score increase" do
    assert_empty Race.new.ability_score_increases
  end
  
  test "by default, a Race provides no proficiency" do
    assert_empty Race.new.proficiencies
  end

  test "by default, a Race provides no language" do
    assert_empty Race.new.languages
  end
  
  test "when extending a Character, a Race redefines its `#base_speed`" do
    dwarf = Race.new speed: 25.feet
    gloin = Character.new
    
    refute_equal 25.feet, gloin.base_speed
    gloin.extend(dwarf)
    assert_equal 25.feet, gloin.base_speed
  end
  
  test "when extending a Character, a Race redefines its `#darkvision`" do
    elf     = Race.new darkvision: 60.feet
    legolas = Character.new
    
    refute_equal 60, legolas.darkvision
    legolas.extend(elf)
    assert_equal 60.feet, legolas.darkvision
  end
  
  test "#subrace creates a subrace of the current Race" do
    race = Race.new

    subrace = race.subrace

    assert_kind_of Race, subrace
    assert_equal race, subrace.original_race
  end
  
  test "a member of a subrace is also a member of the original race" do
    race    = Race.new
    subrace = Race.new subrace_of: race

    character = Character.new
    character.extend(subrace)

    assert_kind_of subrace, character
    assert_kind_of race, character
  end
  
  test "a subrace has the ability score increases of its original race added to its own" do
    race    = Race.new ability_score_increases: { strength: 1, constitution: 1 }
    subrace = Race.new ability_score_increases: { strength: 1, dexterity: 1 }, subrace_of: race

    assert_equal 2, subrace.ability_score_increases[:strength]
    assert_equal 1, subrace.ability_score_increases[:constitution]
    assert_equal 1, subrace.ability_score_increases[:dexterity]
  end
  
  test "a subrace has the proficiencies of its original race added to its own, removing duplicates" do
    race    = Race.new proficiencies: [:light_armor, :simple_weapons]
    subrace = Race.new proficiencies: [:light_armor, :martial_weapons], subrace_of: race

    assert_includes subrace.proficiencies, :light_armor
    assert_includes subrace.proficiencies, :simple_weapons
    assert_includes subrace.proficiencies, :martial_weapons
    assert_equal 3, subrace.proficiencies.count
  end

  test "a subrace has the languages of its original race added to its own, removing duplicates" do
    race    = Race.new languages: [:common, :dwarvish]
    subrace = Race.new languages: [:common, :elvish], subrace_of: race

    assert_includes subrace.languages, :common
    assert_includes subrace.languages, :elvish
    assert_includes subrace.languages, :dwarvish
    assert_equal 3, subrace.languages.count
  end
  
  test "when extending a Character, a subrace redefinition of `#base_speed` takes over its original race's" do
    gnome      = Race.new speed: 25.feet
    deep_gnome = Race.new speed: 20.feet, subrace_of: gnome
    
    firble = Character.new race: deep_gnome
    
    assert_equal 20.feet, firble.base_speed
  end
  
  test "when extending a Character, a subrace redefinition of `#darkvision` takes over its original race's" do
    elf  = Race.new darkvision: 60.feet
    drow = Race.new darkvision: 120.feet, subrace_of: elf
    
    drizzt = Character.new race: drow
    
    assert_equal 120.feet, drizzt.darkvision
  end
end
