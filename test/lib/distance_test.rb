require "test_helper"

class DistanceTest < ActiveSupport::TestCase
  test "a Distance object is immutable" do
    assert_raises(RuntimeError) { Distance.new(10).instance_variable_set(:@length, 20) }
  end
  
  test "addition: two Distance objects can be added" do
    assert_equal Distance.new(20), Distance.new(10) + Distance.new(10)
  end
  
  test "addition: 0 can be added to a Distance" do
    assert_equal Distance.new(4.2), Distance.new(4.2) + 0
  end
  
  test "addition: a numeric value other than 0 cannot be added to a Distance" do
    assert_raises(TypeError) { Distance.new(10) + 2.5 }
  end
  
  test "substraction: a Distance can be substracted from another Distance" do
    assert_equal Distance.new(2), Distance.new(10.3) - Distance.new(8.3)
  end
  
  test "substract: 0 can be substracted from a Distance" do
    assert_equal Distance.new(2), Distance.new(2) - 0
  end
  
  test "substraction: a numeric value other than 0 cannot be substracted from a Distance" do
    assert_raises(TypeError) { Distance.new(2) - 1.5 }
  end
  
  test "substraction: a Distance is never reduced to less than 0" do
    assert_equal Distance.new(0), Distance.new(10) - Distance.new(20)
  end
  
  test "multiplication: a Distance can be multiplied by a numeric value" do
    assert_equal Distance.new(16), Distance.new(4) * 4
  end
  
  test "multiplication: two Distances cannot be multiplied" do
    assert_raises(TypeError) { Distance.new(2) * Distance.new(4) }
  end
  
  test "division: a Distance can be divided by a numeric value" do
    assert_equal Distance.new(1.5), Distance.new(3) / 2
  end
  
  test "division: a Distance can be divided by another Distance" do
    assert_equal 2, Distance.new(9) / Distance.new(4)
  end
  
  test "division: a Distance cannot be used to divide a numeric value" do
    assert_raises(TypeError) { 8 / Distance.new(4) }
  end
end
