class Color < Tuple
  attr_accessor :red, :green, :blue
  alias_method(:red, :x)
  alias_method(:green, :y)
  alias_method(:blue,:z)

  def initialize(*args)
    super(*args)
    @w = 0
  end

  def hadamard_product(other)
    newred = red * other.red
    newgreen = green * other.green
    newblue = blue * other.blue
    Color.new(newred, newgreen, newblue)
  end


end
