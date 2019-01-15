require "./tests/test_helper.rb"

class TickTest < MiniTest::Test

  def setup
    # gravity -0.1 unit/tick, and wind is -0.01 unit/tick
    gravity = Vector.new(0, -0.1, 0)
    wind = Vector.new(-0.01, 0, 0)
    @environment = Environment.new(gravity, wind)
  end

  def test_ticks
    # projectile starts one unit above the origin.
    # velocity is normalized to 1 unit/tick.
    init_position = Point.new(0,1,0)
    init_velocity = Vector.new(1, 1, 0).normalize
    @projectile = Projectile.new(init_position, init_velocity)

    while @projectile.position.y >= 0 do
      puts "projectile (#{@projectile.position.x},#{@projectile.position.y})"
      @projectile.tick(@environment)
    end
  end

  def test_draw_canvas
    canvas = Canvas.new(900, 550)
    @red = Color.new(1, 0, 0)
    init_position = Point.new(0,1,0)
    init_velocity = Vector.new(1, 1.8, 0).normalize * 11.25
    @projectile = Projectile.new(init_position, init_velocity)

    while @projectile.position.y >= 0 do
      canvas_y = (canvas.height - @projectile.position.y).round
      canvas_x = @projectile.position.x.round
      puts "canvas #{canvas_x}, #{canvas_y}"
#      canvas.pixels[canvas_x][canvas_y] = @red unless (canvas_x > canvas.width or canvas_y > canvas.height)
      canvas.pixels[canvas_y][canvas_x] = @red
      @projectile.tick(@environment)
    end

  end

end
