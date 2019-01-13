require 'test_helper'

class TestPoint < MiniTest::Test

  def test_point_subtraction
    @ExpectedAnswer = Vector.new(-2, -4, -6)
    @ActualAnswer = @p1 - @p2
    assert_equal @ExpectedAnswer, @ActualAnswer
  end

end
