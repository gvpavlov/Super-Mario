require 'gosu'
require 'mario'
#require 'map'

class Game < Gosu::Window
  def initialize
    super 600, 300, false
    self.caption = "Super Mario"
    @background = Gosu::Image.new(self, File.dirname(__FILE__) +
                                            "/lib/media/background.png", true)
    @font = Gosu::Font.new(self, Gosu::default_font_name, 20)
    @song = Gosu::Song.new(self, File.dirname(__FILE__) +
                                            "/lib/media/music.ogg")
    @x = @y = 0
    @mario = Mario.new(self, 300, 150)
    @start_time = Time.now
    @frame = 0
  end

  def update
    @frame += 1
    close if button_down? Gosu::KbEscape
    @song.play unless @song.playing?
    @mario.update @frame
    # Camera 'follows' mario, but doesn't exceed map boundaries.
    @x = [[@mario.x - 300, 0].max, @map.width * 30 - 600].min
    @y = [[@mario.y - 150, 0].max, @map.height * 30 - 300].min
  end

  def draw
    @background.draw(0, 0, 0)
    @font.draw("#{time}", 0, 0, 100, 1.0, 1.0, 0xff808080)
    @mario.draw(@x, @y)
  end

  def time
    "Elapsed time: %0.2d:%0.2d" % [(Time.now - @start_time) / 60,
                                    (Time.now - @start_time) % 60]
  end
end

Game.new.show
