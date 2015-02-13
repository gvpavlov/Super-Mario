require 'core/unit'

class Mario < Unit
  attr_reader :dead

  def initialize window, x, y, map
    super(window, x, y, map, 35, 30)
    @mario = Gosu::Image.load_tiles(@window, File.dirname(__FILE__) +
                                      "/gui/media/little_mario.png",
                                      @width, @height, true)
    @jump_sound = Gosu::Sample.new(@window, File.dirname(__FILE__) +
                                            "/gui/media/jump_sound.ogg")
    @power_up_sound = Gosu::Sample.new(@window, File.dirname(__FILE__) +
                                            "/gui/media/power_up_sound.ogg")
    @shrink = Gosu::Sample.new(@window, File.dirname(__FILE__) +
                                            "/gui/media/shrink.ogg")
    @frame = @invincible = 0
    @moving = @dead = false
  end

  def update
    @frame += 1 if @window.frame % 5 == 0
    @invincible -= 1 unless @invincible == 0
    @moving = false
    move
    jump
    die if (@y + @height) == 570
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
    goomba unless @invincible > 0
  end

  def mushroom
    @window.mushrooms.each do |mushroom|
      if touches?(mushroom.x, mushroom.y) and mushroom.active
        grow
        @map.score += 200
        @window.mushrooms.delete(mushroom)
      end
    end
  end

  def goomba
    @window.goombas.each do |goomba|
      if touches?(goomba.x, goomba.y) and (not goomba.dead)
        if (@y + @height) == goomba.y
          @map.score += 300
          @velocity = 8
          goomba.dead = true
          goomba.time_of_death = Time.now
        elsif @height == 60
          @shrink.play
          shrink
        else
          die
        end
      end
    end   
  end

  def touches? x, y
    if @height == 30
      ((@x - x).abs <= 30) and ((@y - y).abs <= 30)
    else
      ((@x - x).abs <= 30) and (((@y - y).abs <= 30) or ((@y + @height) == y))
    end
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
    @height = 60
    @y -= 30
    @power_up_sound.play
    @mario = Gosu::Image.load_tiles(@window, File.dirname(__FILE__) +
                                      "/gui/media/big_mario.png",
                                      @width, @height, true)
  end

  def shrink
    @height = 30
    @y += 30
    @invincible = 60
    @mario = Gosu::Image.load_tiles(@window, File.dirname(__FILE__) +
                                      "/gui/media/little_mario.png",
                                      @width, @height, true)
  end
  
  def die
    @dead = true
    @mario = Gosu::Image.new(@window, File.dirname(__FILE__) +
                                  "/gui/media/mario_dies.png", true)
  end
end
