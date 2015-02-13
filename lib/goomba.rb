require 'unit'

class Goomba < Unit
  def initialize window, x, y, map
    super(window, x, y, map, 35, 30, :left)
    @goomba = Gosu::Image.load_tiles(@window, File.dirname(__FILE__) +
                                      "/media/goomba.png",
                                      @width, @height, true)
    @frame = 0
  end

  def update
    @frame += 1 if @window.frame % 5 == 0
    super
  end

  def draw
    f = @frame % 2
    if @direction == :left
      @goomba[f].draw(@x - @window.x, @y - @window.y, 1)
    else
      @goomba[f].draw(@x + @width - @window.x, @y - @window.y, 1, -1, 1)
    end
  end
end