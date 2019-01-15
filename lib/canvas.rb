class Canvas

  attr_accessor :width, :height, :pixels

  def initialize(width, height)
    @width, @height = width, height
    black = Color.new(0, 0, 0)
    @pixels = Array.new(height){Array.new(width, black)}
  end

  def pixel(row, column)
    @pixels[row][column]
  end

  def to_ppm
    puts "P3"
    puts "#{width} #{height}"
    puts "255"

    pixels.each do |row|
      charcount = 0

      row.each do |rowcol|
        for color in 0..2
          scaled_color = rowcol.to_a[color] * MAXCOLOR
          scaled_color = MINCOLOR if scaled_color <= MINCOLOR
          scaled_color = MAXCOLOR if scaled_color >= MAXCOLOR
          if charcount + scaled_color.round.to_s.length < MAXPPMLINE
            print "#{scaled_color.round} "
            charcount += scaled_color.round.to_s.length + 1
          else
            print "\n"
            print "#{scaled_color.round} "
            charcount = scaled_color.round.to_s.length + 1
          end
        end
      end
      print "\n" # end the PPM with a newline char
    end
  end

end