require 'core/mushroom'

class MushroomGUI < Mushroom
  attr_accessor :active
  
  def initialize window, x, y, map
    super(window, x, y, map)
    @mushroom = Gosu::Image.new(window, File.dirname(__FILE__) +
                                          "/media/mushroom.png", true)
  end

  def draw
    if @direction == :right
      @mushroom.draw(@x - @window.x, @y - @window.y, 1)
    else
      @mushroom.draw(@x + @width - @window.x, @y - @window.y, 1, -1, 1)
    end
  end
end
