require 'core/mario'

class MarioGUI < Mario
  def initialize window, x, y, map
    super(window, x, y, map)
    @mario = Gosu::Image.load_tiles(@window, File.dirname(__FILE__) +
                                      "/media/little_mario.png",
                                      @width, @height, true)
    @jump_sound = Gosu::Sample.new(@window, File.dirname(__FILE__) +
                                            "/media/jump_sound.ogg")
    @power_up_sound = Gosu::Sample.new(@window, File.dirname(__FILE__) +
                                            "/media/power_up_sound.ogg")
    @shrink = Gosu::Sample.new(@window, File.dirname(__FILE__) +
                                            "/media/shrink.ogg")
  end

  def draw
    if @dead
      @mario.draw(@x - @window.x, @y - @window.y, 1)
    else
      f = @frame % 3
      if @velocity != 0
        image = @mario[4]
      else
        image = @moving ? @mario[f] : @mario[5]
      end
      if @direction == :right
        image.draw(@x - @window.x, @y - @window.y, 1)
      else
        image.draw(@x + @width - @window.x, @y - @window.y, 1, -1, 1)
      end
    end
  end

  def grow
    super
    @power_up_sound.play
    @mario = Gosu::Image.load_tiles(@window, File.dirname(__FILE__) +
                                      "/media/big_mario.png",
                                      @width, @height, true)
  end

  def shrink
    super
    @mario = Gosu::Image.load_tiles(@window, File.dirname(__FILE__) +
                                      "/media/little_mario.png",
                                      @width, @height, true)
  end
  
  def die
    super
    @mario = Gosu::Image.new(@window, File.dirname(__FILE__) +
                                  "/media/mario_dies.png", true)
  end
end
