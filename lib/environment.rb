class Environment
  attr_accessor :gravity, :wind

  def initialize (gravity, wind)
    @gravity, @wind = gravity, wind
  end

end