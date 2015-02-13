require 'lib/core/goomba'

class GoombaGUI < Goomba
  def initialize window, x, y, map
    super(window, x, y, map)
    @goomba = Gosu::Image.load_tiles(@window, File.dirname(__FILE__) +
                                      "/media/goomba.png",
                                      @width, @height, true)
  end

  def draw
    if @dead
      f = 2
    else
      f = @frame % 2
    end

    if @direction == :left
      @goomba[f].draw(@x - @window.x, @y - @window.y, 1)
    else
      @goomba[f].draw(@x + @width - @window.x, @y - @window.y, 1, -1, 1)
    end
  end
end