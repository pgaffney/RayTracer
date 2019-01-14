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
    w = 0
    while w < newCanvas.width
      h = 0
      while h < newCanvas.height
        puts "checking pixel #{w}, #{h}: #{newCanvas.pixel(w,h)}"
        assert_equal(newCanvas.pixel(w,h),@black)
        h += 1
      end
      w += 1
    end
  end

end