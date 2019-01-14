class Canvas

  attr_accessor :width, :height, :pixels

  def initialize(width, height)
    @width, @height = width, height
    black = Color.new(0, 0, 0)
    @pixels = Array.new(width){Array.new(height, black)}
  end

  def pixel(x, y)
    @pixels[x][y]
  end

  def to_ppm
    puts "P3"
    puts "#{width} #{height}"
    puts "255"
  end

end