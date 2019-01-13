class Color < Tuple
  attr_accessor :r, :g, :b
  alias_method(:r, :x)
  alias_method(:g, :y)
  alias_method(:b,:z)

  def initialize(*args)
    super(*args)
    @w = 0
  end

end
