require 'spec_helper'
require 'core/map'

describe Map do

  let(:game) do
    Game.new
  end

  let(:map) do
    Map.new(game)
  end

  describe "#initialize" do
    it "creates a map object" do 
      expect(map.is_a? Map).to eq true
    end
  end

  describe "#obsticle?" do
    it "returns false if tile is empty" do
      map.tiles[0][0] = '.'
      expect(map.obsticle?(0, 0)).to eq false
    end

    it "checks if mario has reached the end" do
      map.tiles[0][0] = '^'
      map.window.mario.x = 0
      map.obsticle?(0,0)
      expect(map.window.won).to eq true
    end

    it "returns true if it's an obsticle" do
      map.tiles[0][0] = 'e'
      expect(map.obsticle?(0, 0)).to eq true
    end
  end

  describe "#collect_coin" do
    it "changes the score" do
      score = map.score
      map.collect_coin(0, 0)
      expect(map.score != score).to eq true
    end

    it "changes the tile" do
      map.tiles[0][0] = 'e'
      map.collect_coin(0, 0)
      expect(map.tiles[0][0] == '.').to eq true
    end
  end

  describe "#spawn_mushroom" do
    before :each do
      map.tiles[0][1] = '.'
      map.window.mario.y = 30
      mushroom = Mushroom.new(map.window, 0, 0, map)
      map.window.mushrooms << mushroom
    end

    it "changes question block to normal block" do
      map.spawn_mushroom(0, 1)
      expect(map.tiles[0][1] == '-').to eq true
    end

    it "activates the mushroom" do
      map.spawn_mushroom(0, 1)
      expect(map.shroom.first.active).to eq true
    end
  end
end