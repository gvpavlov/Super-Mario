require 'gosu'
require 'mario'
require 'map'
require 'goomba'
require 'mushroom'

class Game < Gosu::Window
  attr_reader :x, :y, :frame
  attr_accessor :mushrooms, :goombas

  def initialize
    super @width = 900, @height = 480, false
    self.caption = "Super Mario"
    @background = Gosu::Image.new(self, File.dirname(__FILE__) +
                                            "/lib/media/background.png", true)
    @font = Gosu::Font.new(self, Gosu::default_font_name, 20)
    @song = Gosu::Song.new(self, File.dirname(__FILE__) +
                                            "/lib/media/music.ogg")
    @game_over_sound = Gosu::Song.new(self, File.dirname(__FILE__) +
                                            "/lib/media/game_over_sound.ogg")
    @x = 0
    @y = 90
    @map = Map.new self
    @mario = Mario.new(self, 90, 420, @map)
    @start_time = Time.now
    @frame = 0
    @mushrooms = []
    @goombas = []

    # read map from file
    # remove the \n regerated through #readlines
    lines = File.readlines("lib/media/map.txt").map { |line| line.strip }
    @map.height = lines.size
    @map.width = lines[0].size
    @map.tiles = Array.new(@map.width) do |x|
      Array.new(@map.height) do |y|
        lines[y][x]
      end
    end

    @map.height.times do |y|
      @map.width.times do |x|
        case @map.tiles[x][y]
          when 'm'
            mushrooms << Mushroom.new(self, x * 30, y * 30, @map)
            @map.tiles[x][y] = '.'
          when 'g'
            goombas << Goomba.new(self, x * 30, y * 30, @map)
            @map.tiles[x][y] = '.'
        end
      end
    end
  end

  def update
    @frame += 1
    if @mario.dead
      @song.stop
      @game_over_sound.play(false)
    else
      @song.play(true)
    end
    @map.update
    @mario.update unless @mario.dead
    @goombas.each do |g|
      if g.dead
        if (Time.now - g.time_of_death) > 2
          @goombas.delete(g)
        end
      else
        g.update
      end
    end
    @mushrooms.each { |m| m.update }
    # Camera 'follows' mario, but doesn't exceed map boundaries.
    @x = [[@mario.x - @width / 2, 0].max, @map.width * 30 - @width].min
  end

  def button_down id
    case id
      when Gosu::KbUp 
        @mario.try_jumping
      when Gosu::KbEscape
        close
    end
  end   

  def draw
    @background.draw(0, 0, 0)
    @font.draw("#{time}", 40, 0, 100, 1.0, 1.0, 0xff808080)
    @font.draw("Score: " + @map.score.to_s, 760, 0, 100, 1.0, 1.0, 0xff808080)
    @map.draw
    @mario.draw
    @goombas.each { |g| g.draw }
    @mushrooms.each { |m| m.draw }
  end

  def time
    "Time: %0.2d:%0.2d" % [(Time.now - @start_time) / 60,
                                    (Time.now - @start_time) % 60]
  end
end

Game.new.show
