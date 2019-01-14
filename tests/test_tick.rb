require "./tests/test_helper.rb"

class TickTest < MiniTest::Test

  def setup
    # projectile starts one unit above the origin.
    # velocity is normalized to 1 unit/tick.
    initpos = Point.new(0,1,0)
    initvel = Vector.new(1, 1, 0).normalize
    @proj = Projectile.new(initpos, initvel)

    # gravity -0.1 unit/tick, and wind is -0.01 unit/tick
    gravity = Vector.new(0, -0.1, 0)
    wind = Vector.new(-0.01, 0, 0)
    @env = Environment.new(gravity, wind)
  end

  def test_ticks
    while @proj.p.y >= 0 do
      puts "projectile (#{@proj.p.x},#{@proj.p.y})"
      @proj.tick(@env)
    end
  end

end
