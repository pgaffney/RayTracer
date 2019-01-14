require "./tests/test_helper.rb"

class PointTest < MiniTest::Test

  def test_point_subtraction
    @p1 = Point.new(3, 2, 1)
    @p2 = Point.new(5, 6, 7)
    @ExpectedAnswer = Vector.new(-2, -4, -6)
    @ActualAnswer = @p1 - @p2
    assert_equal @ExpectedAnswer, @ActualAnswer
  end

end
