require 'core/unit'

class Goomba < Unit
  attr_accessor :dead, :time_of_death 
  attr_reader :frame

  def initialize window, x, y, map
    super(window, x, y, map, 35, 30, :left)
    @frame = 0
    @dead = false
    @time_of_death = 0
  end

  def update
    @frame += 1 if @window.frame % 5 == 0
    super
  end
end