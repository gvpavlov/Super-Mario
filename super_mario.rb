require 'gosu'
require 'mario'
#require 'map'

class Game < Gosu::Window
  def initialize
    super width = 800, height = 600, fullscreen = false
    self.caption = "Super Mario"
    @mario = Mario.new self
  end

  def update
    close if button_down? Gosu::KbEscape
    @mario.update
  end

  def draw
    @mario.draw
  end
end

Game.new.show
