require 'unit'

class Mario < Unit
  def initialize window, x, y, map
    super(window, x, y, map, 35, 30)
    @mario = Gosu::Image.load_tiles(@window, File.dirname(__FILE__) +
                                      "/media/little_mario.png",
                                      @width, @height, true)
    @jump_sound = Gosu::Sample.new(@window, File.dirname(__FILE__) +
                                            "/media/jump_sound.ogg")
    @power_up_sound = Gosu::Sample.new(@window, File.dirname(__FILE__) +
                                            "/media/power_up_sound.ogg")
    @frame = 0
    @moving = false
  end

  def update
    @frame += 1 if @window.frame % 5 == 0
    @moving = false
    move
    jump
  end

  def move
    if @window.button_down? Gosu::KbLeft
      @direction = :left
      @moving = true
      5.times do  
        if fits?(-1, 0)
          @x += -1
          touch_unit?
        end
      end
    elsif @window.button_down? Gosu::KbRight
      @direction = :right
      @moving = true
      5.times do
        if fits?(1, 0)
          @x += 1
          touch_unit?
        end
      end
    end
  end

  def jump
    @velocity -= 1
    if @velocity < 0
      (-@velocity).times do 
        if fits?(0, 1) 
          @y += 1
          touch_unit?
        else 
          @velocity = 0
        end
      end
    end
    if @velocity > 0
      @velocity.times do
        if fits?(0, -1) 
          @y -= 1
          touch_unit?
        else 
          @velocity = 0 
        end
      end
    end
  end

  def try_jumping
    if fits?(0, 1) or fits?(0, -1)
      if @velocity == 0
        @jump_sound.play 0.2
        @velocity = 17
      end
    end
  end

  def touch_unit?
    mushroom
  end

  def mushroom
    @window.mushrooms.each do |mushroom|
      if touches?(mushroom.x, mushroom.y)
        grow
        @window.mushrooms.delete(mushroom)
      end
    end
  end

  def touches? x, y
    ((@x - x).abs <= 30) and ((@y - y).abs <= 30)
  end

  def draw
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

  def grow
    @height = 60
    @y -= 30
    @power_up_sound.play
    @mario = Gosu::Image.load_tiles(@window, File.dirname(__FILE__) +
                                      "/media/big_mario.png",
                                      @width, @height, true)
  end

  def shrink
    @height = 30
    @y += 30
    @mario = Gosu::Image.load_tiles(@window, File.dirname(__FILE__) +
                                      "/media/little_mario.png",
                                      @width, @height, true)
  end
  # TODO: Can cause draw to fail because it's not an array.
  def death
    @mario = Gosu::Image.new(@window, File.dirname(__FILE__) +
                                  "/media/mario_dies.png", true)
  end
end
