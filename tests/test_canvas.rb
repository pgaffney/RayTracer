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

end