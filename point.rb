class Point < Tuple
  attr_accessor :x, :y, :z

  def initialize(*args)
    super(*args)
    @w = POINT
  end

end
