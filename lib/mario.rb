require 'unit'

class Mario < Unit
  def initialize window, x, y, map
    super(window, x, y, map)
    @mario = Gosu::Image.load_tiles(@window, File.dirname(__FILE__) +
                                      "/media/little_mario.png",
                                      @width, @height, true)
    @frame = 0
    @moving = false
  end

  def update
    @frame += 1 if @window.frame % 5 == 0
    @moving = false
    if @window.button_down? Gosu::KbLeft
      @direction = :left
      @moving = true
      5.times {@x += -1 if fits?(-1, 0)} 
    elsif @window.button_down? Gosu::KbRight
      @direction = :right
      @moving = true
      5.times {@x += 1 if fits?(1, 0)}
    end
    jump
  end

  def jump
    move_y
    
    if @velocity > 0
      @velocity.times do
        if fits?(0, -1) 
          @y -= 1 
        else 
          @velocity = 0 
        end
      end
    end
  end

  def try_jumping
    if fits?(0, 1) or fits?(0, -1) 
      @velocity = 17 unless @velocity != 0
    end
  end

  def draw
    f = @frame % 3
    if @velocity != 0
      image = @mario[4]
    else
      image = @moving ? @mario[f] : @mario[5]
    end
    if @direction == :right
      image.draw(@x - @window.x, @y, 1)
    else
      image.draw(@x + @width - @window.x, @y, 1, -1, 1)
    end
  end

  def grow
    @width, @height = 35, 60
    @mario = Gosu::Image.load_tiles @window, File.dirname(__FILE__) +
                                            "/media/big_mario.png",
                                   @width, @height, true
  end
  # TODO: Can cause draw to fail because it's not an array.
  def death
    @mario = Gosu::Image.new(@window, File.dirname(__FILE__) +
                                  "/media/mario_dies.png", true)
  end
end
