require "test_helper"

class CodexTest < ActiveSupport::TestCase
  test "values can be set on initialization" do
    codex = Codex.new(:abyssal, :bard, :cantrip)
    
    assert_includes codex, :abyssal
    assert_includes codex, :bard
    assert_includes codex, :cantrip
  end
  
  test "values can be added as both symbols or strings" do
    codex = Codex.new
    codex << :deity
    codex.add "eldritch"
    
    assert_includes codex, :deity
    assert_includes codex, :eldritch
  end
  
  test "#expand includes all the values in a group" do
    codex_class = Class.new(Codex)
    codex_class.groups = {
      dungeons: [:crypt, :mine, :temple],
      dragons: [:red, :black, :silver, :gold]
    }
    
    codex = codex_class.new(:dragons, :lich)
    expanded_codex = codex.expand
    
    assert_includes expanded_codex, :red
    assert_includes expanded_codex, :black
    assert_includes expanded_codex, :silver
    assert_includes expanded_codex, :gold
    assert_includes expanded_codex, :lich
  end
  
  test "Codex::Type#cast can cast to a specific kind of Codex" do
    codex_class = Class.new(Codex)
    type = Codex::Type.new(codex_class)
    
    assert_kind_of codex_class, type.cast([:familiar, :gold])
  end
  
  test "Codex::Type#serialize returns an array" do
    codex = Codex.new :hireling, :inspiration
    type = Codex::Type.new
    
    assert_equal [:hireling, :inspiration], type.serialize(codex)
  end
  
  test "Codex::Type detects changes in the set" do
    old_codex = Codex.new :knight
    new_codex = Codex.new :lock
    type      = Codex::Type.new
    
    assert type.changed_in_place? old_codex, new_codex
  end
end
