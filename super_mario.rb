require 'gosu'
require 'mario'
#require 'map'

class Game < Gosu::Window
  def initialize
    super 300, 360, false
    self.caption = "Super Mario"
    @background = Gosu::Image.new(self, File.dirname(__FILE__) +
                                            "/lib/media/background.png", true)
    @font = Gosu::Font.new(self, Gosu::default_font_name, 20)
    @song = Gosu::Song.new(self, File.dirname(__FILE__) +
                                            "/lib/media/music.ogg")
    @mario = Mario.new self
    @start_time = Time.now
    @frame = 0
  end

  def update
    @frame += 1
    close if button_down? Gosu::KbEscape
    @song.play unless @song.playing?
    @mario.update @frame
  end

  def draw
    @background.draw(0, 0, 0)
    @font.draw("#{time}", 0, 0, 100, 1.0, 1.0, 0xff808080)
    @mario.draw
  end

  def time
    "Elapsed time: %0.2d:%0.2d" % [(Time.now - @start_time) / 60, (Time.now - @start_time) % 60]
  end
end

Game.new.show
