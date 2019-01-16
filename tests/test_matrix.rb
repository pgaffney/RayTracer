require './tests/test_helper.rb'

class MatrixTest < MiniTest::Test

  def setup
    @matrix1 = Matrix.rows([[1, 2, 3, 4], [5.5, 6.5, 7.5, 8.5], [9, 10, 11, 12], [13.5, 14.5, 15.5, 16.5]])
    @matrix2 = Matrix.rows([[1, 2, 3, 4], [5.5, 6.5, 7.5, 8.5], [9, 10, 11, 12], [13.5, 14.5, 15.5, 16.5]])
    @matrix3 = Matrix.rows([[5, 6, 7, 8], [5.5, 6.5, 7.5, 8.5], [9, 10, 11, 12], [13.5, 14.5, 15.5, 16.5]])
    @matrixA = Matrix.rows([[1, 2, 3, 4], [5, 6, 7, 8], [9, 8, 7, 6], [5, 4, 3, 2]])
    @matrixB = Matrix.rows([[-2, 1, 2, 3], [3, 2, 1, -1], [4, 3, 6, 5], [1, 2, 7, 8]])
  end

  def test_matrix_basics
    assert_equal @matrix1[0, 0], 1
    assert_equal @matrix2[0, 3], 4
  end

  def test_equality
    assert @matrix1 == @matrix2
    assert @matrix2 != @matrix3
    @matrixC = @matrixA * @matrixB
    @matrixD = Matrix.rows([[20, 22, 50, 48], [44, 54, 114, 108], [40, 58, 110, 102], [16, 26, 46, 42]])
    assert_equal @matrixC, @matrixD
  end

  def test_transpose
    puts @matrix1.to_s
    @matrixT = @matrix1.transpose
    puts @matrixT.to_s
  end

  def test_inverse

  end

end