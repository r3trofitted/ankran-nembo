require "test_helper"

class CodexTest < ActiveSupport::TestCase
  test "Values can be set on initialization" do
    codex = Codex[:abyssal, :bard, :cantrip]
    
    assert_includes codex, "abyssal"
    assert_includes codex, "bard"
    assert_includes codex, "cantrip"
  end
  
  test "Values can be added as both symbols or strings" do
    codex = Codex.new
    codex << "deity"
    codex.add :eldritch
    
    assert_includes codex, "deity"
    assert_includes codex, "eldritch"
  end
  
  test "Values can be merged as both symbols and strings" do
    codex = Codex.new
    codex.merge ["fiend", :gladiator]
    
    assert_includes codex, "fiend"
    assert_includes codex, "gladiator"
  end
  
  test "#include? accepts a symbol" do
    assert Codex["hermit"].include?(:hermit)
  end
  
  test "#include? returns true if one of the codex's groups contains the given value" do
    codex_class = Class.new(Codex) do
      self.groups = { dungeons: [:crypt, :mine, :temple] }
    end
    codex = codex_class.new([:dungeons])
    
    assert codex.include?("crypt")
  end
  
  test "#expand includes all the values in a group and the groups themselves" do
    codex_class = Class.new(Codex) do
      self.groups = { dragons: %i[red black silver gold] }
    end
    
    codex = codex_class.new([:dragons, :lich])
    expanded_codex = codex.expand
    
    assert_includes expanded_codex, "red"     # the group values
    assert_includes expanded_codex, "black"
    assert_includes expanded_codex, "silver"
    assert_includes expanded_codex, "gold"
    assert_includes expanded_codex, "dragons" # the group itself
    assert_includes expanded_codex, "lich"    # the extra, non-group value
  end
  
  test "#expand doesn't break if the codex class has no group" do
    assert_nothing_raised do
      Codex[:inspiration].expand
    end
  end
  
  test ".pick returns a Codex::Pick object" do
    assert_kind_of Codex::Pick, Codex.pick(1, from: [:mapping, :navigating])
  end
  
  test "a Codex::Pick object has a count and a list" do
    pick = Codex::Pick.new(count: 2, list: [:outlander, :panther])
    
    assert_equal 2, pick.count
    assert_includes pick.list, :outlander
    assert_includes pick.list, :panther
  end
  
  test "a Codex::Pick object cannot have a count higher than the length of its list" do
    assert_raises(ArgumentError) { Codex::Pick.new(count: 3, list: [:quasit, :ranger]) }
  end
  
  test "Codex::Type#cast can cast to a specific kind of Codex" do
    codex_class = Class.new(Codex)
    type = Codex::Type.new(codex_class)
    
    assert_kind_of codex_class, type.cast([:familiar, :gold])
  end
  
  test "Codex::Type#serialize returns an array" do
    codex = Codex.new [:hireling, :inspiration]
    type = Codex::Type.new
    
    assert_equal ["hireling", "inspiration"], type.serialize(codex)
  end
  
  test "Codex::Type detects changes in the set" do
    old_codex = Codex.new [:knight]
    new_codex = Codex.new [:lock]
    type      = Codex::Type.new
    
    assert type.changed_in_place? old_codex, new_codex
  end
end
