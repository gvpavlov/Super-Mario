require 'gosu'
require 'mario'
require 'map'

class Game < Gosu::Window
  def initialize
    super @width = 900, @height = 420, false
    self.caption = "Super Mario"
    @background = Gosu::Image.new(self, File.dirname(__FILE__) +
                                            "/lib/media/background.png", true)
    @font = Gosu::Font.new(self, Gosu::default_font_name, 20)
    @song = Gosu::Song.new(self, File.dirname(__FILE__) +
                                            "/lib/media/music.ogg")
    @x = 0
    @map = Map.new self
    @mario = Mario.new(@map, self, 810, 300)
    @start_time = Time.now
    @frame = 0
  end

  def update
    @frame += 1
    close if button_down? Gosu::KbEscape
    #@song.play unless @song.playing?
    @map.update @frame
    @mario.update @frame
    # Camera 'follows' mario, but doesn't exceed map boundaries.
    @x = [[@mario.x - @width / 2, 0].max, @map.width * 30 - @width].min
  end

  def button_down id
    if id == Gosu::KbUp
      @mario.velocity = 15
    end
  end   

  def draw
    @background.draw(0, 0, 0)
    @font.draw("#{time}", 40, 0, 100, 1.0, 1.0, 0xff808080)
    @map.draw(@x)
    @mario.draw(@x)
  end

  def time
    "Time: %0.2d:%0.2d" % [(Time.now - @start_time) / 60,
                                    (Time.now - @start_time) % 60]
  end
end

Game.new.show
