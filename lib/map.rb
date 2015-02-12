class Map
  attr_reader :width, :height, :tiles, :score

  def initialize window
    @block = Gosu::Image.new(window, File.dirname(__FILE__) +
                                            "/media/block.png", true)
    @ground = Gosu::Image.new(window, File.dirname(__FILE__) +
                                            "/media/ground.png", true)
    @pipe = Gosu::Image.new(window, File.dirname(__FILE__) +
                                            "/media/pipe.png", true)
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
    # read map from file
    # remove the \n regerated through #readlines
    lines = File.readlines("lib/media/map.txt").map { |line| line.strip }
    @height = lines.size
    @width = lines[0].size
    @tiles = Array.new(@width) do |x|
      Array.new(@height) do |y|
        lines[y][x]
      end
    end
  end

  def update
    @frame += 1 if @window.frame % 20 == 0
  end

  def draw_coin x, y
    f = @frame % 3
    @coin[f].draw(x * 30 - @window.x - 2.5, y * 30, 1)
  end

  def draw_qblock x, y
    f = @frame % 3
    @question_block[f].draw(x * 30 - @window.x, y * 30, 1)
  end

  def draw
    @height.times do |y|
      @width.times do |x|
        case tiles[x][y]
          when '='
            @ground.draw(x * 30 - @window.x, y * 30, 1)
          when '*'
            @block.draw(x * 30 - @window.x, y * 30, 1)
          when '?'
            draw_qblock(x, y)
          when '$'
            draw_coin(x, y)
          when '|'
            @pipe.draw(x * 30 - @window.x, y * 30, 1)
          when '/'
            @pipe_lower.draw(x * 30 - @window.x, y * 30, 1)
        end        
      end
    end
  end

  def obsticle? x, y
    if @tiles[x / 30][y / 30] == '.'
      false
    elsif @tiles[x / 30][y / 30] == '$'
      collect_coin(x,y)
      false
    else
      true
    end
  end

  def collect_coin x, y
    @collect_coin_sound.play 0.5
    @score += 100
    @tiles[x / 30][y / 30] = '.'
  end
end