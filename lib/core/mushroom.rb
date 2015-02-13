require 'core/unit'

class Mushroom < Unit
  attr_accessor :active
  
  def initialize window, x, y, map
    super(window, x, y, map, 30)
    @active = false
  end

  def update
    super
  end
end
