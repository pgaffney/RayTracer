class Vector < Tuple
  attr_accessor :x, :y, :z

  def initialize(*args)
    super(*args)
    @w = VECTOR
  end

  def normalize
    m = self.magnitude
    Vector.new(x/m, y/m, z/m)
  end

  def cross(other)
    crossX = y * other.z - z * other.y
    crossY = z * other.x - x * other.z
    crossZ = x * other.y - y * other.x
    Vector.new(crossX, crossY, crossZ)
  end

end
