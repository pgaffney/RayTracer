class Canvas

  attr_accessor :width, :height, :pixels

  def initialize(width, height)
    @width, @height = width, height
    black = Color.new(0, 0, 0)
    @pixels = Array.new(height){Array.new(width, black)}
  end

  def pixel(x, y)
    @pixels[x][y]
  end

  def to_ppm
    puts "P3"
    puts "#{width} #{height}"
    puts "255"
    pixels.each do |row|
      row.each do |rowcol|

        scaledred = rowcol.red * MAXCOLOR
        scaledred = MINCOLOR if scaledred <= MINCOLOR
        scaledred = MAXCOLOR if scaledred >= MAXCOLOR

        scaledgreen = rowcol.green * MAXCOLOR
        scaledgreen = MINCOLOR if scaledgreen <= MINCOLOR
        scaledgreen = MAXCOLOR if scaledgreen >= MAXCOLOR

        scaledblue = rowcol.blue * MAXCOLOR
        scaledblue = MINCOLOR if scaledblue <= MINCOLOR
        scaledblue = MAXCOLOR if scaledblue >= MAXCOLOR

        print "#{scaledred.round} #{scaledgreen.round} #{scaledblue.round} "
      end
      print "\n"
    end

    def scale

    end

  end

end