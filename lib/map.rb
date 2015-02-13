class Map
  attr_accessor :width, :height, :tiles, :score

  def initialize window
    @block = Gosu::Image.new(window, File.dirname(__FILE__) +
                                            "/media/block.png", true)
    @ground = Gosu::Image.new(window, File.dirname(__FILE__) +
                                            "/media/ground.png", true)
    @pipe = Gosu::Image.new(window, File.dirname(__FILE__) +
                                            "/media/pipe.png", true)
    @pole_head = Gosu::Image.new(window, File.dirname(__FILE__) +
                                            "/media/pole_head.png", true)
    @pole = Gosu::Image.new(window, File.dirname(__FILE__) +
                                            "/media/pole_foundation.png", true)
    @pipe_lower = Gosu::Image.new(window, File.dirname(__FILE__) +
                                            "/media/pipe_lower.png", true)
    @mushroom = Gosu::Image.new(window, File.dirname(__FILE__) +
                                            "/media/mushroom.png", true)
    @question_block = Gosu::Image.load_tiles(window, File.dirname(__FILE__) +
                                              "/media/question_block.png",
                                                30, 30, true)
    @coin = Gosu::Image.load_tiles(window, File.dirname(__FILE__) +
                                              "/media/coin.png",
                                                35, 30, true)
    @collect_coin_sound = Gosu::Sample.new(window, File.dirname(__FILE__) +
                                            "/media/collect_coin_sound.ogg")
    @window = window
    @score = 0
    @frame = 0
    @tiles = [[]]
  end

  def update
    @frame += 1 if @window.frame % 20 == 0
  end

  def draw_coin x, y
    f = @frame % 3
    @coin[f].draw(x * 30 - @window.x - 2.5, y * 30 - @window.y, 1)
  end

  def draw_qblock x, y, s
    if s == '?'
      f = @frame % 3
    else
      f = 3
    end
    @question_block[f].draw(x * 30 - @window.x, y * 30 - @window.y, 1)
  end

  def draw
    @height.times do |y|
      @width.times do |x|
        case tiles[x][y]
          when '='
            @ground.draw(x * 30 - @window.x, y * 30 - @window.y, 1)
          when '*'
            @block.draw(x * 30 - @window.x, y * 30 - @window.y, 1)
          when '^'
            @pole.draw(x * 30 - @window.x, y * 30 - @window.y, 1)
          when 'o'
            @pole_head.draw(x * 30 - @window.x, y * 30 - @window.y, 1)
          when '?'
            draw_qblock(x, y, '?')
          when '-'
            draw_qblock(x, y, '-')
          when '$'
            draw_coin(x, y)
          when '|'
            @pipe.draw(x * 30 - @window.x, y * 30 - @window.y, 1)
          when '/'
            @pipe_lower.draw(x * 30 - @window.x, y * 30 - @window.y, 1)
        end        
      end
    end
  end

  def obsticle? x, y
    x /= 30
    y /= 30
    case @tiles[x][y]
      when '.'
        false
      when '$'
        collect_coin(x,y)
        false
      when '?'
        if @window.mario.y / 30 == y and @window.mario.y >= y * 30
          shroom = @window.mushrooms.select do |shroom|
            (shroom.x == x * 30) and
            (shroom.y == (y - 1) * 30)
          end
          shroom.first.active = true
          @tiles[x][y] = '-'
        end
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
    @collect_coin_sound.play 0.5
    @score += 100
    @tiles[x][y] = '.'
  end
end