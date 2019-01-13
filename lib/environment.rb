class Environment
  attr_accessor :g, :w

  def initialize (gravity, wind)
    @g = gravity
    @w = wind
  end

end