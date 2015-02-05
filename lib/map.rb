class Map
  attr_reader :width, :height

  def initialize window
    @block = Gosu::Image.new(window, File.dirname(__FILE__) +
                                            "/media/block.png", true)
    @ground = Gosu::Image.new(window, File.dirname(__FILE__) +
                                            "/media/ground.png", true)
    @pipe = Gosu::Image.new(window, File.dirname(__FILE__) +
                                            "/media/pipe.png", true)
    @mushroom = Gosu::Image.new(window, File.dirname(__FILE__) +
                                            "/media/mushroom.png", true)
    @question_block = Gosu::Image.load_tiles(window, File.dirname(__FILE__) +
                                              "/media/question_block.png",
                                                30, 30, true)
    @coin = Gosu::Image.load_tiles(window, File.dirname(__FILE__) +
                                              "/media/coin.png",
                                                35, 30, true)
    @coins = []
    @frame = 0
    # read map from file
    # remove the \n regerated through #readlines
    @tiles = File.readlines("lib/media/map.txt").map { |line| line.chop }
    @height = @tiles.size
    @width = @tiles[0].size
  end

  def update frame
    @frame += 1 if frame % 20 == 0
  end

  def draw_coin x, y, screen_x
    f = @frame % 3
    @coin[f].draw(x * 30 - screen_x - 2.5, y * 30, 1)
  end

  def draw_qblock x, y, screen_x
    f = @frame % 3
    @question_block[f].draw(x * 30 - screen_x, y * 30, 1)
  end

  def draw screen_x
    @height.times do |y|
      @width.times do |x|
        case tile = @tiles[y][x]
          when '='
            @ground.draw(x * 30 - screen_x, y * 30, 1)
          when '*'
            @block.draw(x * 30 - screen_x, y * 30, 1)
          when '?'
            draw_qblock(x, y, screen_x)
          when '$'
            draw_coin(x, y, screen_x)
          when '|'
            @pipe.draw(x * 30 - screen_x, y * 30, 1)
          else nil
        end
      end
    end
  end

  # Reversed coordinates because they are read from the file.
  def obsticle? y, x
    if @tiles[x / 30][y / 30] == '.'
      false
    else
      true
    end
  end
end