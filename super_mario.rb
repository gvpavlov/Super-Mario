require "gosu"
#require 'mario'

class Game < Gosu::Window
  def initialize
    super width = 800, height = 600, fullscreen = false
    self.caption = "Super Mario"
    @mario = Mario.new self
  end

  def update
    @mario.update
  end

  def draw
    @mario.draw
  end
end

class Mario
  def initialize window
    @window = window
    #images
    @width, @height = 102, 137
    @idle = Gosu::Image.new(@window, "lib/images/mario-idle.png", false)
    @move = Gosu::Image.load_tiles @window, "lib/images/mario.png",
                                   @width, @height, true
    # center image
    @x = @window.width/2 - @width/2
    @y = @window.height/2 - @height/2
    #direction and movement
    @direction = :right
    @frame = 0
    @moving = false
  end

  def update
    @frame += 1
    @moving = false
    if @window.button_down? Gosu::KbLeft
      @direction = :left
      @moving = true
      @x += -5
    elsif @window.button_down? Gosu::KbRight
      @direction = :right
      @moving = true
      @x += 5
    end
  end

  def draw
    f = @frame % 6
    image = @moving ? @move[f] : @idle
    if @direction == :right
      image.draw @x, @y, 1
    else
      image.draw @x + @width, @y, 1, -1, 1
    end
  end
end

Game.new.show
