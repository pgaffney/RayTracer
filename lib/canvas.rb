class Canvas

  attr_accessor :width, :height, :pixels

  def initialize(width, height)
    @width, @height = width, height
    black = Color.new(0, 0, 0)
    @pixels = Array.new(height){Array.new(width, black)}
  end

  def pixel(column, row)
    @pixels[column][row]
  end

  # create output in PPM format
  # fixed header:
  #  P3
  #  width, height
  #  Maximun color value
  # detail lines:
  #  in lines of length no more than MAXPPMLINEs,
  #  scaled red green and blue values output as space delimited integers
  #  (scaling is from MINCOLOR to MAXCOLOR, linear rounded integers, negatives clamped to minimum
  #  over max clamped to maximum)
  def to_ppm
    puts "P3"
    puts "#{width} #{height}"
    puts "#{MAXCOLOR}"

    pixels.each do |row|
      charcount = 0
      row.each do |rowcol|
        rowcol.to_a.each do |color|
          scaled_color = color * MAXCOLOR
          scaled_color = MINCOLOR if scaled_color <= MINCOLOR
          scaled_color = MAXCOLOR if scaled_color >= MAXCOLOR
          if charcount + scaled_color.round.to_s.length < MAXPPMLINE # if we are still less than a line
            print "#{scaled_color.round} "                       # print the color value and its space delim
            charcount += scaled_color.round.to_s.length + 1          # increment the character count
          else
            print "\n"                                           # since we have gone over the line limit
            print "#{scaled_color.round} "                       # print a newline and the color value + delim
            charcount = scaled_color.round.to_s.length + 1           # reset the character count
          end
        end
      end
      print "\n" # end the PPM with a newline char
    end
  end

end