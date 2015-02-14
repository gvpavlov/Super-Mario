require 'core/unit'

class Mario < Unit
  attr_accessor :invincible, :moving, :velocity, :window, :dead

  def initialize window, x, y, map
    super(window, x, y, map, 35, 30)
    @invincible = 0
    @moving = @dead = false
  end

  def update
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

  def grow
    @height = 60
    @y -= 30
  end

  def shrink
    @height = 30
    @y += 30
    @invincible = 60
  end
  
  def die
    @dead = true
  end
end
