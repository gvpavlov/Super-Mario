require 'gosu'
require 'mario'
require 'map'
require 'goomba'
require 'mushroom'

class Game < Gosu::Window
  attr_reader :x, :y, :frame, :mushrooms, :goombas

  def initialize
    super @width = 900, @height = 480, false
    self.caption = "Super Mario"
    @background = Gosu::Image.new(self, File.dirname(__FILE__) +
                                            "/lib/media/background.png", true)
    @font = Gosu::Font.new(self, Gosu::default_font_name, 20)
    @song = Gosu::Song.new(self, File.dirname(__FILE__) +
                                            "/lib/media/music.ogg")
    @x = 0
    @y = 90
    @map = Map.new self
    @mario = Mario.new(self, 90, 420, @map)
    @start_time = Time.now
    @frame = 0
    fill_units
  end

  def fill_units
    @mushrooms = []
    @mushrooms << Mushroom.new(self, 240, 180, @map)
    @goombas = []
    @goombas << Goomba.new(self, 30, 300, @map)
    @goombas << Goomba.new(self, 240, 150, @map)
  end

  def update
    @frame += 1
    @song.play(true)
    @map.update
    @mario.update
    @goombas.each do |g|
      if g.dead
        if (Time.now - g.time_of_death) > 2
          @goombas.delete(g)
        end
      else
        g.update
      end
    end
    @mushrooms.each { |m| m.update }
    # Camera 'follows' mario, but doesn't exceed map boundaries.
    @x = [[@mario.x - @width / 2, 0].max, @map.width * 30 - @width].min
  end

  def button_down id
    case id
      when Gosu::KbUp 
        @mario.try_jumping
      when Gosu::KbEscape
        close
    end
  end   

  def draw
    @background.draw(0, 0, 0)
    @font.draw("#{time}", 40, 0, 100, 1.0, 1.0, 0xff808080)
    @font.draw("Score: " + @map.score.to_s, 760, 0, 100, 1.0, 1.0, 0xff808080)
    @map.draw
    @mario.draw
    @goombas.each { |g| g.draw }
    @mushrooms.each { |m| m.draw }
  end

  def time
    "Time: %0.2d:%0.2d" % [(Time.now - @start_time) / 60,
                                    (Time.now - @start_time) % 60]
  end
end

Game.new.show
