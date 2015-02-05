class Mario
  attr_reader :x, :y

  def initialize window, x, y
    @window = window
    @width, @height = 35, 30
    @mario = Gosu::Image.load_tiles @window, File.dirname(__FILE__) +
                                            "/media/little_mario.png",
                                   @width, @height, true
    @x, @y = x, y
    @direction = :right
    @frame = 0
    @moving = false
  end

  def update frame
    @frame += 1 if frame % 11 == 0
    @moving = false
    if @window.button_down? Gosu::KbLeft
      @direction = :left
      @moving = true
      @x += -5
    elsif @window.button_down? Gosu::KbRight
      @direction = :right
      @moving = true
      @x += 5
    end
  end

  def draw screen_x
    f = @frame % 3
    image = @moving ? @mario[f] : @mario[5]
    if @direction == :right
      image.draw(@x - screen_x, @y, 1)
    else
      image.draw(@x + @width - screen_x, @y, 1, -1, 1)
    end
  end

  def grow
    @width, @height = 35, 60
    @mario = Gosu::Image.load_tiles @window, File.dirname(__FILE__) +
                                            "/media/big_mario.png",
                                   @width, @height, true
  end
  # TODO: Can cause draw to fail because it's not an array.
  def death
    @mario = Gosu::Image.new(@window, File.dirname(__FILE__) +
                                  "/media/mario_dies.png", true)
  end
end
