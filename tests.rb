#!/usr/bin/env ruby
# -*- ruby -*-

require './tuple.rb'
require './point.rb'
require './vector.rb'
require './color.rb'
require './projectile.rb'
require './environment.rb'
require './color.rb'

require 'minitest/autorun'
require 'minitest/reporters'

Minitest::Reporters.use!

class TestTuple < MiniTest::Test

  def setup
    @a = Point.new(4.3, -4.2, 3.1)
    @b = Vector.new(4.3, -4.2, 3.1)
    @a1 = Tuple.new(3, -2, 5, 1)
    @a2 = Tuple.new(-2, 3, 1, 0)
    @p1 = Point.new(3, 2, 1)
    @p2 = Point.new(5, 6, 7)
  end

  def test_tuple_coordinates_are_correct
    assert_equal 4.3, @a.x
    assert_equal -4.2, @a.y
    assert_equal 3.1, @a.z
    assert_equal 1.0, @a.w
    assert_equal 4.3, @b.x
    assert_equal -4.2, @b.y
    assert_equal 3.1, @b.z
    assert_equal 0.0, @b.w
  end

  def test_tuple_a_is_point_and_b_is_vector
    assert_equal POINT, @a.w
    assert_equal VECTOR, @b.w
  end

  def test_tuple_math
    @ExpectedAnswer = Tuple.new(1,1,6,1)
    @ActualAnswer = @a1 + @a2
    assert_equal @ExpectedAnswer, @ActualAnswer
  end

  def test_point_subtraction
    @ExpectedAnswer = Vector.new(-2, -4, -6)
    @ActualAnswer = @p1 - @p2
    assert_equal @ExpectedAnswer, @ActualAnswer
  end

  def test_tuple_subtraction
    @ExpectedAnswer = Tuple.new(-2, -4, -6, VECTOR)
    @ActualAnswer = @p1 - @p2
    assert_equal @ExpectedAnswer, @ActualAnswer
  end

  def test_subtracting_a_vector_from_a_point
    @p = Point.new(3, 2, 1)
    @v = Vector.new(5, 6, 7)
    @ExpectedAnswer = Point.new(-2, -4, -6)
    @ActualAnswer = @p - @v
    assert_equal @ExpectedAnswer, @ActualAnswer
  end

  def test_subtracting_two_vectors
    @v1 = Vector.new(3, 2, 1)
    @v2 = Vector.new(5, 6, 7)
    @ExpectedAnswer = Vector.new(-2, -4, -6)
    @ActualAnswer = @v1 - @v2
    assert_equal @ExpectedAnswer, @ActualAnswer
  end

  def test_unary_negate
    @a = Tuple.new(1, -2, 3, -4)
    @ExpectedNegate = Tuple.new(-1, 2, -3, 4)
    assert_equal @ExpectedNegate, -@a

    @ActualNegate = -@a
    assert_equal @ExpectedNegate, @ActualNegate
    assert_equal @ActualNegate, -@a
  end

  def test_multiply_a_tuple_by_a_scalar
    @a = Tuple.new(1, -2, 3, -4)
    @ExpectedMultiple = Tuple.new(3.5, -7, 10.5, -14)
    @ActualMultiple = @a * 3.5
    assert_equal @ActualMultiple, @ExpectedMultiple
  end

  def test_multiply_a_tuple_by_a_fraction
    @a = Tuple.new(1, -2, 3, -4)
    @ExpectedMultiple = Tuple.new(0.5, -1, 1.5, -2)
    @ActualMultiple = @a * 0.5
    assert_equal @ActualMultiple, @ExpectedMultiple
  end

  def test_divide_a_tuple_by_a_scalar
    @a = Tuple.new(1, -2, 3, -4)
    @ExpectedQuotient = Tuple.new(0.5, -1, 1.5, -2)
    @ActualQuotient = @a / 2.0
    assert_equal @ActualQuotient, @ExpectedQuotient
  end

  def test_magnitude_calcs_correctly
    @v = Vector.new(1, 0, 0)
    assert_equal 1, @v.magnitude
    @v = Vector.new(1, 2, 3)
    assert_equal Math.sqrt(14), @v.magnitude
  end

  def test_normalize_calcs_correctly
    @v = Vector.new(4, 0, 0)
    @normv = @v.normalize
    @ExpectedAnswer = Vector.new( 1, 0, 0)
    assert_equal @normv, @ExpectedAnswer

    @v = Vector.new(1, 2, 3)
    @normv = @v.normalize
    @ExpectedX = 1 / Math.sqrt(14)
    @ExpectedY = 2 / Math.sqrt(14)
    @ExpectedZ = 3 / Math.sqrt(14)
    @ExpectedAnswer = Vector.new( @ExpectedX, @ExpectedY, @ExpectedZ)
    assert_equal @normv, @ExpectedAnswer
  end

  def test_dot_product
    @a = Vector.new(1, 2, 3)
    @b = Vector.new(2, 3, 4)
    @ExpectedDotProduct = 20
    @ActualDotProduct = @a.dot(@b)
    assert_equal @ExpectedDotProduct, @ActualDotProduct
  end

  def test_cross_product
    @a = Vector.new(1, 2, 3)
    @b = Vector.new(2, 3, 4)
    @Expected_ab_CrossProduct = Vector.new(-1, 2, -1)
    @Actual_ab_CrossProduct = @a.cross(@b)
    assert_equal @Expected_ab_CrossProduct, @Actual_ab_CrossProduct
    @Expected_ba_CrossProduct = Vector.new(1, -2, 1)
    @Actual_ba_CrossProduct = @b.cross(@a)
    assert_equal @Expected_ba_CrossProduct, @Actual_ba_CrossProduct
  end

  def test_equal_method
    assert(equal(1.0000000000001,1))
    not assert(equal(1,7))
  end

  def test_color_basics
    @c = Color.new(-0.5, 0.4, 1.7)
    assert_equal @c.r, -0.5
    assert_equal @c.g, 0.4
    assert_equal @c.b, 1.7
  end

end

class TestTick < MiniTest::Test

  def setup
    # projectile starts one unit above the origin.
    # velocity is normalized to 1 unit/tick.
    initpos = Point.new(0,1,0)
    initvel = Vector.new(1, 1, 0).normalize
    @proj = Projectile.new(initpos, initvel)

    # gravity -0.1 unit/tick, and wind is -0.01 unit/tick
    gravity = Vector.new(0, -0.1, 0)
    wind = Vector.new(-0.01, 0, 0)
    @env = Environment.new(gravity, wind)
  end

  def test_ticks
    while @proj.p.y >= 0 do
      puts "projectile (#{@proj.p.x},#{@proj.p.y})"
      @proj.tick(@env)
    end
  end

end

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

  def test_adding_colors
    @ExpectedAnswer = Color.new(1.6, 0.7, 1.0)
    @ActualAnswer = @c1 + @c2
    assert_equal @ExpectedAnswer, @ActualAnswer
  end

end