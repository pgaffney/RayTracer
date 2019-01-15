POINT = 1.0
VECTOR = 0.0
MINCOLOR = 0
MAXCOLOR = 255
MAXPPMLINE = 70

# floating point math insurance
EPSILON = 0.0000001
def equal(a,b)
  (a.abs - b.abs) < EPSILON
end

class Tuple
  attr_accessor :x, :y, :z, :w

  def initialize(*args)
    @x, @y, @z, @w = args[0], args[1], args[2], args[3]
  end

  def +(other)
    Tuple.new(x + other.x, y + other.y, z + other.z, w + other.w)
  end

  def -(other)
    Tuple.new(x - other.x, y - other.y, z - other.z, w - other.w)
  end

  def -@
    Tuple.new(-x, -y, -z, -w)
  end

  def *(m)
    Tuple.new(x * m, y * m, z * m, w * m)
  end

  def /(d)
    Tuple.new(x / d, y / d, z / d, w / d)
  end

  def to_s
    "(#{x}, #{y}, #{z}, #{w})"
  end

  def ==(other)
    equal(x, other.x) && equal(y, other.y) && equal(z, other.z) && equal(w, other.w)
  end

  def magnitude
    Math.sqrt(((x**2) + (y**2) + (z**2) + (w**2)))
  end

  def dot(other)
    x * other.x + y * other.y + z * other.z + w * other.w
  end

end
