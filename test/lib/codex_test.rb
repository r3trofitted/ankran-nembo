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
  
  test ".pick returns an unavailable Pick object" do
    pick = Codex.pick(1, from: [:mapping, :navigating])
    
    assert_kind_of Pick, pick
    refute pick.available?
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
