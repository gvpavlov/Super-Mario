require 'map'

class Mario
  attr_reader :x, :y
  attr_accessor :velocity

  def initialize map, window, x, y
    @window = window
    @map = map
    @width, @height = 35, 30
    @mario = Gosu::Image.load_tiles(@window, File.dirname(__FILE__) +
                                      "/media/little_mario.png",
                                      @width, @height, true)
    @x, @y = x, y
    @direction = :right
    @frame = 0
    @velocity = 0
    @moving = false
  end

  def update frame
    @frame += 1 if frame % 11 == 0
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
    @velocity -= 1
    if @velocity > 0
      @velocity.times do
        if fits?(0, -1)  
          @y -= 1 
        else
          @velocity = 0 
        end
      end
    elsif @velocity < 0
      (-@velocity).times do 
        if fits?(0, 1) 
          @y += 1 
        else 
          @velocity = 0 
        end
      end
    end
  end

  # Checks the top and bottom center for collisions.
  def fits? offset_x, offset_y
    if @direction == :left
      (not @map.obsticle?(@x + offset_x + 5, @y + offset_y + 5)) and
      (not @map.obsticle?(@x + offset_x + 5, @y + offset_y + @height - 5))
    else
      (not @map.obsticle?(@x + offset_x - 6 + @width, @y + offset_y + 5)) and
      (not @map.obsticle?(@x + offset_x - 6 + @width, @y + offset_y + @height - 5))
    end
  end

  def draw screen_x
    f = @frame % 3
    if @velocity != 0
      image = @mario[4]
    else
      image = @moving ? @mario[f] : @mario[5]
    end
    if @direction == :right
      image.draw(@x - screen_x, @y, 1)
    else
      image.draw(@x + @width - screen_x, @y, 1, -1, 1)
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
