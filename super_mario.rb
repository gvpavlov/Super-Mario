require "gosu"
require 'mario'

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

Game.new.show
