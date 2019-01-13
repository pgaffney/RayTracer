require "./tests/test_helper.rb"

class TestVector < MiniTest::Test

  def test_subtracting_two_vectors
    @v1 = Vector.new(3, 2, 1)
    @v2 = Vector.new(5, 6, 7)
    @ExpectedAnswer = Vector.new(-2, -4, -6)
    @ActualAnswer = @v1 - @v2
    assert_equal @ExpectedAnswer, @ActualAnswer
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

end
