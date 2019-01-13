class Projectile
  attr_accessor :p, :v

  def initialize (position, velocity)
    @p = position
    @v = velocity
  end

  def to_s
    "(#{p}, #{v})"
  end

  def tick (env)
    startp = self.p
    startv = self.v
    @p = startp + startv
    @v = startv + env.g + env.w
  end

end