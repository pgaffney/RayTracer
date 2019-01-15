require './tests/test_helper.rb'

class MatrixTest < MiniTest::Test

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    matrix = Matrix.new(4, 4)
    matrix[0] = [1,2,3,4]
    matrix[1] = [5.5,6.5,7.5,8.5]
    matrix[2] = [9,10,11,12]
    matrix[3] = [13.5,14.5,15.5,16.5]
  end

  def test_matrix_basics
    puts @matrix
    assert_equal @matrix[0][0], 1
    assert_equal @matrix[0][3], 4
  end
end