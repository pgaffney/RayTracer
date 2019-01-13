require "./tests/test_helper.rb"

class TestColor < MiniTest::Test

  def setup
    @c = Color.new(0.2, 0.3, 0.4)
    @c1 = Color.new(0.9, 0.6, 0.75)
    @c2 = Color.new(0.7, 0.1, 0.25)
  end

  def test_rgb_alias
    assert_equal @c1.r, 0.9
    assert_equal @c1.x, 0.9
  end

  def test_color_basics
    @c = Color.new(-0.5, 0.4, 1.7)
    assert_equal @c.r, -0.5
    assert_equal @c.g, 0.4
    assert_equal @c.b, 1.7
  end

  def test_adding_colors
    @ExpectedAnswer = Color.new(1.6, 0.7, 1.0)
    @ActualAnswer = @c1 + @c2
    assert_equal @ExpectedAnswer, @ActualAnswer
  end

end