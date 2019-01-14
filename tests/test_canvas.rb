require "./tests/test_helper.rb"

class CanvasTest < MiniTest::Test

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    # Do nothing
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.

  def teardown
    # Do nothing
  end

  def test_creating_a_canvas
    newCanvas = Canvas.new(10, 20)
    assert_equal(newCanvas.height, 20)
    assert_equal(newCanvas.width, 10)
  end

  def test_all_pixels_are_black_in_new_canvas
    newCanvas = Canvas.new(10, 20)
    @black = Color.new(0, 0, 0)
    newCanvas.pixels.each do |row|
      row.each do |rowcol|
        assert_equal(rowcol,@black)
      end
    end
  end

  def test_write_pixel_to_canvas
    newCanvas = Canvas.new(10, 20)
    @red = Color.new(1, 0, 0)
    newCanvas.pixels[2][3] = @red
    assert_equal(newCanvas.pixel(2,3), @red)
  end

  def test_canvas_to_ppm
    newCanvas = Canvas.new(5, 3)
    color1 = Color.new(1.5, 0, 0)
    color2 = Color.new(0, 0.5, 0)
    color3 = Color.new(-0.5, 0, 1)
    newCanvas.pixels[0][0] = color1
    newCanvas.pixels[1][2] = color2
    newCanvas.pixels[2][4] = color3
    assert_output (/P3\n5 3\n255\n255 0 0 0 0 0 0 0 0 0 0 0 0 0 0 \n0 0 0 0 0 0 0 128 0 0 0 0 0 0 0 \n0 0 0 0 0 0 0 0 0 0 0 0 0 0 255 \n/) {newCanvas.to_ppm}
  end
end