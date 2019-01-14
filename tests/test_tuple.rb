require "./tests/test_helper.rb"

class TupleTest < MiniTest::Test

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

  def test_equal_method
    assert(equal(1.0000000000001,1))
    not assert(equal(1,7))
  end

end
