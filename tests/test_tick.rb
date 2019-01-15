require "./tests/test_helper.rb"

class TickTest < MiniTest::Test

  def setup
    # projectile starts one unit above the origin.
    # velocity is normalized to 1 unit/tick.
    init_position = Point.new(0,1,0)
    init_velocity = Vector.new(1, 1, 0).normalize
    @projectile = Projectile.new(init_position, init_velocity)

    # gravity -0.1 unit/tick, and wind is -0.01 unit/tick
    gravity = Vector.new(0, -0.1, 0)
    wind = Vector.new(-0.01, 0, 0)
    @environment = Environment.new(gravity, wind)
  end

  def test_ticks
    while @projectile.position.y >= 0 do
      puts "projectile (#{@projectile.position.x},#{@projectile.position.y})"
      @projectile.tick(@environment)
    end
  end

end
