require 'gosu'
require 'mario'
#require 'map'

class Game < Gosu::Window
  def initialize
    super width = 800, height = 600, fullscreen = false
    self.caption = "Super Mario"
    @background = Gosu::Image.new(self, File.dirname(__FILE__) +
                                            "/lib/media/background.png", true)
    @font = Gosu::Font.new(self, Gosu::default_font_name, 20)
    @song = Gosu::Song.new(self, File.dirname(__FILE__) +
                                            "/lib/media/music.ogg")
    @mario = Mario.new self
    @start_time = Time.now
  end

  def update
    close if button_down? Gosu::KbEscape
    @mario.update
    @song.play unless @song.playing?
  end

  def draw
    @background.draw(0, 0, 0)
    @mario.draw
    @font.draw("#{elapsed}", 0, 0, 100, 1.0, 1.0, 0xffffff00)
  end

  def elapsed
    "%0.2d:%0.2d" % [(Time.now - @start_time) / 60, (Time.now - @start_time) % 60]
  end
end

Game.new.show
