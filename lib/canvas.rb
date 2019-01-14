class Canvas

  attr_accessor :width, :height, :pixel, :pixels

  def initialize(width, height)
    @width, @height = width, height
    @pixels = Array.new(width){Array.new(height, Color.new(0, 0, 0))}
  end

  def pixel(x, y)
    @pixels[x][y]
  end

end