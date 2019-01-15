class Projectile
  attr_accessor :position, :velocity

  def initialize (position, velocity)
    @position, @velocity = position, velocity
  end

  def to_s
    "(#{position}, #{velocity})"
  end

  def tick (environment)
    start_position = self.position
    start_velocity = self.velocity
    @position = start_position + start_velocity
    @velocity = start_velocity + environment.gravity + environment.wind
  end

end