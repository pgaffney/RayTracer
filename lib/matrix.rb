class Matrix
  attr_accessor :columns, :rows, :values

  def initialize(columns, rows)
    @wcolumns, @rows = columns, rows
    @values = Array.new(rows){Array.new(columns, 0)}
  end

  def value(row, column)
    @values[row][column]
  end
end