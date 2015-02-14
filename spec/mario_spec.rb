require 'spec_helper'
require 'core/mario'

describe Mario do

  let(:game) do
    Game.new
  end

  let(:map) do
    Map.new(game)
  end

  let(:mario) do
    Mario.new(game, 0, 0, map)
  end

  describe "#initialize" do
    it "creates mario object" do
      expect(mario.is_a? Mario).to eq true
    end
  end

  describe "#update" do
    it "doesn't change invincibility if 0" do
      invincibility = mario.invincible
      mario.update
      expect(mario.invincible == invincibility).to eq true
    end

    it "lowers invincibility unless it's 0" do
      mario.invincible = 5
      mario.update
      expect(mario.invincible != 0).to eq true
    end

    it "sets moving to false" do
      mario.moving = true
      mario.update
      expect(mario.moving).to eq false
    end
  end

  describe "#jump" do
    it "changes velocity" do
      mario.velocity = 30
      mario.jump
      expect(mario.velocity != 30).to eq true
    end

    it "inscreases y" do
      mario.velocity = -10
      mario.map.tiles[0][0] = '.'
      mario.map.tiles[0][1] = '.'
      mario.y = 0
      mario.jump
      expect(mario.y != 0).to eq true
    end

    it "decreases y" do
      mario.velocity = 10
      mario.map.tiles[0][0] = '.'
      mario.map.tiles[0][1] = '.'
      mario.y = 1
      mario.jump
      expect(mario.y != 1).to eq true
    end
  end

  describe "#mushroom" do
    before :each do
      mushroom = Mushroom.new(mario.window, 0, 0, map)
      mushroom.active = true
      mario.window.mushrooms << mushroom
      mario.x = mario.y = 0
    end

    it "increases score" do
      mario.map.score = 0
      mario.mushroom
      expect(mario.map.score != 0).to eq true
    end
  end

  describe "#touches?" do
    it "returns true with height 30" do
      mario.height = 30
      mario.x = mario.y = 0
      expect(mario.touches?(0, 0)).to eq true
    end

    it "returns false with height 30" do
      mario.height = 30
      mario.x = mario.y = 120
      expect(mario.touches?(0, 0)).to eq false
    end

    it "returns true with height 60" do
      mario.height = 60
      mario.x = mario.y = 0
      expect(mario.touches?(0, 0)).to eq true
    end

    it "returns false with height 60" do
      mario.height = 60
      mario.x = mario.y = 120
      expect(mario.touches?(0, 0)).to eq false
    end
  end

  describe "#grow" do
    it "changes height" do
      mario.height = 30
      mario.grow
      expect(mario.height == 60).to eq true
    end

    it "changes y" do
      mario.y = 30
      mario.grow
      expect(mario.y == 0).to eq true
    end
  end

  describe "#shrink" do
    it "changes height" do
      mario.height = 60
      mario.shrink
      expect(mario.height == 30).to eq true
    end

    it "changes y" do
      mario.y = 0
      mario.shrink
      expect(mario.y == 30).to eq true
    end

    it "initiates invincibility" do
      mario.invincible = 0
      mario.shrink
      expect(mario.invincible != 0).to eq true
    end
  end

  describe "#die" do
    it "it changes death state" do
      mario.dead = false
      mario.die
      expect(mario.dead).to eq true
    end
  end
end