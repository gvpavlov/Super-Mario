class Mario
  def initialize window
    @window = window
    #images
    @width, @height = 35, 30
    @mario = Gosu::Image.load_tiles @window, File.dirname(__FILE__) +
                                            "/media/little_mario.png",
                                   @width, @height, true
    # center image
    @x = @window.width/2 - @width/2
    @y = @window.height/2 - @height/2
    #direction and movement
    @direction = :right
    @f = @frame = 0
    @moving = false
  end

  def update
    @f += 1
    @frame += 1 if @f % 11 == 0
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

  def draw
    f = @frame % 3
    image = @moving ? @mario[f] : @mario[5]
    if @direction == :right
      image.draw @x, @y, 1
    else
      image.draw @x + @width, @y, 1, -1, 1
    end
  end

  def grow
    @width, @height = 35, 60
    @mario = Gosu::Image.load_tiles @window, File.dirname(__FILE__) +
                                            "/media/big_mario.png",
                                   @width, @height, true
  end

  def death
    @mario = Gosu::Image.new(@window, File.dirname(__FILE__) +
                                  "/media/mario_dies.png", true)
  end
end
