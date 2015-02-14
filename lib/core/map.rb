class Map
  attr_accessor :width, :height, :tiles, :score, :window, :shroom

  def initialize window
    @window = window
    @score = 0
    @tiles = [[]]
  end

  def obsticle? x, y
    x /= 30
    y /= 30
    case @tiles[x][y]
      when '.'
        false
      when '$'
        collect_coin(x, y)
        false
      when '?'
        spawn_mushroom(x, y)
        true
      when '-'
        true
      when '^'
        if @window.mario.x == x * 30 
          @window.won = true
        end
        false
      else
        true
    end
  end

  def collect_coin x, y
    @score += 100
    @tiles[x][y] = '.'
  end

  def spawn_mushroom x, y
    if @window.mario.y / 30 == y and @window.mario.y >= y * 30
      @shroom = @window.mushrooms.select do |mushroom|
        (mushroom.x == x * 30) and
        (mushroom.y == (y - 1) * 30)
      end
      @shroom.first.active = true
      @tiles[x][y] = '-'
    end
  end
end