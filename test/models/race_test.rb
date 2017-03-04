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
end
