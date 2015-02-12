require 'map'

class Unit
  attr_accessor :x, :y, :velocity

  def initialize window, x, y, map, width = 35, height = 30, direction = :right
    @window = window
    @map = map
    @x, @y = x, y
    @width, @height = width, height
    @direction = direction
    @velocity = 0
  end

  def move_y
    @velocity -= 1
    if @velocity < 0
      (-@velocity).times do 
        if fits?(0, 1) then @y += 1 else @velocity = 0 end
      end
    end
  end

  # Checks for collisions.
  def fits? offset_x, offset_y
    (not @map.obsticle?(@x + offset_x + 5, @y + offset_y + 2)) and
    (not @map.obsticle?(@x + offset_x + 5, @y + offset_y + @height / 2 - 1)) and
    (not @map.obsticle?(@x + offset_x + 5, @y + offset_y + @height - 1)) and
    (not @map.obsticle?(@x + offset_x - 6 + @width, @y + offset_y + 2)) and
    (not @map.obsticle?(@x + offset_x - 6 + @width, @y + offset_y + @height / 2 - 1)) and
    (not @map.obsticle?(@x + offset_x - 6 + @width, @y + offset_y + @height - 1))
  end

end