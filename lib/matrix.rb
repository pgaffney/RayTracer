class Matrix
  include Enumerable
# instance creations
  private_class_method :new
  attr_reader :rows
  protected :rows

#
# Creates a matrix where each argument is a row.
#   Matrix[ [25, 93], [-1, 66] ]
#      =>  25 93
#          -1 66
#
  def Matrix.[](*rows)
    rows(rows, false)
  end

#
# Creates a matrix where +rows+ is an array of arrays, each of which is a row
# of the matrix.  If the optional argument +copy+ is false, use the given
# arrays as the internal structure of the matrix without copying.
#   Matrix.rows([[25, 93], [-1, 66]])
#      =>  25 93
#          -1 66
#
  def Matrix.rows(rows, copy = true)
    rows = convert_to_array(rows, copy)
    rows.map! do |row|
      convert_to_array(row, copy)
    end
    size = (rows[0] || []).size
    rows.each do |row|
      raise ErrDimensionMismatch, "row size differs (#{row.size} should be #{size})" unless row.size == size
    end
    new rows, size
  end

#
# Returns element (+i+,+j+) of the matrix.  That is: row +i+, column +j+.
#
  def [](i, j)
    @rows.fetch(i){return nil}[j]
  end
  alias element []
  alias component []


  private def set_value(row, col, value)
    raise ErrDimensionMismatch, "Expected a a value, got a #{value.class}" if value.respond_to?(:to_matrix)

    @rows[row][col] = value
  end

#
# Matrix.new is private; use Matrix.rows, columns, [], etc... to create.
#
  def initialize(rows, column_count = rows[0].size)
    # No checking is done at this point. rows must be an Array of Arrays.
    # column_count must be the size of the first row, if there is one,
    # otherwise it *must* be specified and can be any integer >= 0
    @rows = rows
    @column_count = column_count
  end

  private def new_matrix(rows, column_count = rows[0].size) # :nodoc:
    self.class.send(:new, rows, column_count) # bypass privacy of Matrix.new
  end

#
# Returns the number of rows.
#
  def row_count
    @rows.size
  end

  alias_method :row_size, :row_count
#
# Returns the number of columns.
#
  attr_reader :column_count
  alias_method :column_size, :column_count


#--
# OBJECT METHODS -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#++

#
# Returns +true+ if and only if the two matrices contain equal elements.
#
  def ==(other)
    return false unless Matrix === other &&
        column_count == other.column_count # necessary for empty matrices
    rows == other.rows
  end

  def eql?(other)
    return false unless Matrix === other &&
        column_count == other.column_count # necessary for empty matrices
    rows.eql? other.rows
  end

#
# Returns an array of arrays that describe the rows of the matrix.
#
  def to_a
    @rows.collect(&:dup)
  end

  def to_s
    if empty?
      "#{self.class}.empty(#{row_count}, #{column_count})"
    else
      "#{self.class}[" + @rows.collect{|row|
        "[" + row.collect{|e| e.to_s}.join(", ") + "]"
      }.join(", ")+"]"
    end
  end

#
# Returns +true+ if this is an empty matrix, i.e. if the number of rows
# or the number of columns is 0.
#
  def empty?
    column_count == 0 || row_count == 0
  end

#
# Returns +true+ if this is a square matrix.
#
  def square?
    column_count == row_count
  end


#--
# ARITHMETIC -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#++

#
# Returns the determinant of the matrix.
#
# Beware that using Float values can yield erroneous results
# because of their lack of precision.
# Consider using exact types like Rational or BigDecimal instead.
#
#   Matrix[[7,6], [3,9]].determinant
#     => 45
#
  def determinant
    Matrix.Raise ErrDimensionMismatch unless square?
    m = @rows
    case row_count
      # Up to 4x4, give result using Laplacian expansion by minors.
      # This will typically be faster, as well as giving good results
      # in case of Floats
    when 0
      +1
    when 1
      + m[0][0]
    when 2
      + m[0][0] * m[1][1] - m[0][1] * m[1][0]
    when 3
      m0, m1, m2 = m
      + m0[0] * m1[1] * m2[2] - m0[0] * m1[2] * m2[1] \
      - m0[1] * m1[0] * m2[2] + m0[1] * m1[2] * m2[0] \
      + m0[2] * m1[0] * m2[1] - m0[2] * m1[1] * m2[0]
    when 4
      m0, m1, m2, m3 = m
      + m0[0] * m1[1] * m2[2] * m3[3] - m0[0] * m1[1] * m2[3] * m3[2] \
      - m0[0] * m1[2] * m2[1] * m3[3] + m0[0] * m1[2] * m2[3] * m3[1] \
      + m0[0] * m1[3] * m2[1] * m3[2] - m0[0] * m1[3] * m2[2] * m3[1] \
      - m0[1] * m1[0] * m2[2] * m3[3] + m0[1] * m1[0] * m2[3] * m3[2] \
      + m0[1] * m1[2] * m2[0] * m3[3] - m0[1] * m1[2] * m2[3] * m3[0] \
      - m0[1] * m1[3] * m2[0] * m3[2] + m0[1] * m1[3] * m2[2] * m3[0] \
      + m0[2] * m1[0] * m2[1] * m3[3] - m0[2] * m1[0] * m2[3] * m3[1] \
      - m0[2] * m1[1] * m2[0] * m3[3] + m0[2] * m1[1] * m2[3] * m3[0] \
      + m0[2] * m1[3] * m2[0] * m3[1] - m0[2] * m1[3] * m2[1] * m3[0] \
      - m0[3] * m1[0] * m2[1] * m3[2] + m0[3] * m1[0] * m2[2] * m3[1] \
      + m0[3] * m1[1] * m2[0] * m3[2] - m0[3] * m1[1] * m2[2] * m3[0] \
      - m0[3] * m1[2] * m2[0] * m3[1] + m0[3] * m1[2] * m2[1] * m3[0]
    else
      # For bigger matrices, use an efficient and general algorithm.
      # Currently, we use the Gauss-Bareiss algorithm
      determinant_bareiss
    end
  end
  alias_method :det, :determinant

#
# Private. Use Matrix#determinant
#
# Returns the determinant of the matrix, using
# Bareiss' multistep integer-preserving gaussian elimination.
# It has the same computational cost order O(n^3) as standard Gaussian elimination.
# Intermediate results are fraction free and of lower complexity.
# A matrix of Integers will have thus intermediate results that are also Integers,
# with smaller bignums (if any), while a matrix of Float will usually have
# intermediate results with better precision.
#
  private def determinant_bareiss
    size = row_count
    last = size - 1
    a = to_a
    no_pivot = Proc.new{ return 0 }
    sign = +1
    pivot = 1
    size.times do |k|
      previous_pivot = pivot
      if (pivot = a[k][k]) == 0
        switch = (k+1 ... size).find(no_pivot) {|row|
          a[row][k] != 0
        }
        a[switch], a[k] = a[k], a[switch]
        pivot = a[k][k]
        sign = -sign
      end
      (k+1).upto(last) do |i|
        ai = a[i]
        (k+1).upto(last) do |j|
          ai[j] =  (pivot * ai[j] - ai[k] * a[k][j]) / previous_pivot
        end
      end
    end
    sign * pivot
  end
  
#
# Matrix multiplication.
#   Matrix[[2,4], [6,8]] * Matrix.identity(2)
#     => 2 4
#        6 8
#
  def *(m) # m is matrix or vector or number
    case(m)
    when Numeric
      rows = @rows.collect {|row|
        row.collect {|e| e * m }
      }
      return new_matrix rows, column_count
    when Vector
      m = self.class.column_vector(m)
      r = self * m
      return r.column(0)
    when Matrix
      Matrix.Raise ErrDimensionMismatch if column_count != m.row_count

      rows = Array.new(row_count) {|i|
        Array.new(m.column_count) {|j|
          (0 ... column_count).inject(0) do |vij, k|
            vij + self[i, k] * m[k, j]
          end
        }
      }
      return new_matrix rows, m.column_count
    else
      return apply_through_coercion(m, __method__)
    end
  end

#
# Returns the transpose of the matrix.
#   Matrix[[1,2], [3,4], [5,6]]
#     => 1 2
#        3 4
#        5 6
#   Matrix[[1,2], [3,4], [5,6]].transpose
#     => 1 3 5
#        2 4 6
#
  def transpose
    return self.class.empty(column_count, 0) if row_count.zero?
    new_matrix @rows.transpose, row_count
  end
  alias_method :t, :transpose

#
# Returns the inverse of the matrix.
#   Matrix[[-1, -1], [0, -1]].inverse
#     => -1  1
#         0 -1
#
  def inverse
    Matrix.Raise ErrDimensionMismatch unless square?
    self.class.I(row_count).send(:inverse_from, self)
  end
  alias_method :inv, :inverse

  private def inverse_from(src) # :nodoc:
    last = row_count - 1
    a = src.to_a

    0.upto(last) do |k|
      i = k
      akk = a[k][k].abs
      (k+1).upto(last) do |j|
        v = a[j][k].abs
        if v > akk
          i = j
          akk = v
        end
      end
      Matrix.Raise ErrNotRegular if akk == 0
      if i != k
        a[i], a[k] = a[k], a[i]
        @rows[i], @rows[k] = @rows[k], @rows[i]
      end
      akk = a[k][k]

      0.upto(last) do |ii|
        next if ii == k
        q = a[ii][k].quo(akk)
        a[ii][k] = 0

        (k + 1).upto(last) do |j|
          a[ii][j] -= a[k][j] * q
        end
        0.upto(last) do |j|
          @rows[ii][j] -= @rows[k][j] * q
        end
      end

      (k+1).upto(last) do |j|
        a[k][j] = a[k][j].quo(akk)
      end
      0.upto(last) do |j|
        @rows[k][j] = @rows[k][j].quo(akk)
      end
    end
    self
  end

# Private helper modules

  module ConversionHelper # :nodoc:
    #
    # Converts the obj to an Array. If copy is set to true
    # a copy of obj will be made if necessary.
    #
    private def convert_to_array(obj, copy = false) # :nodoc:
      case obj
      when Array
        copy ? obj.dup : obj
      when Vector
        obj.to_a
      else
        begin
          converted = obj.to_ary
        rescue Exception => e
          raise TypeError, "can't convert #{obj.class} into an Array (#{e.message})"
        end
        raise TypeError, "#{obj.class}#to_ary should return an Array" unless converted.is_a? Array
        converted
      end
    end
  end

  extend ConversionHelper

end



