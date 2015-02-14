require 'spec_helper'
require 'game'

describe Game do 

  let(:game) do
    Game.new
  end

  let(:map) do
    MapGUI.new(Game.new)
  end

  let(:mario) do
    MarioGUI.new(game, 900, 30, map)
  end

  describe "#new" do

    it "loads a game object" do
      expect(game.is_a? Game).to eq true
    end

    context "reads from a file" do
      it "loads file in an array" do
        expect(map.tiles.empty?).to eq false
      end

      it "loads mario" do
        expect(mario.x).to eq 900
      end


      it "loads mushrooms" do
        mushrooms = []
        mushrooms << MushroomGUI.new(game, 30, 30, map)
        expect(mushrooms.empty?).to eq false
      end

      it "loads goombas" do
        goombas = []
        goombas << GoombaGUI.new(game, 30, 30, map)
        expect(goombas.empty?).to eq false
      end
    end
  end

  describe "#update" do
    it "adds frames" do
      frame = game.frame
      game.update
      expect(game.frame).to eq frame + 1 
    end

    it "camera follows mario" do
      game.mario.x = 1500
      game.update
      expect(game.x == 0).to eq false
    end
  end

  describe "#time" do
    it "counts the playtime" do
      game.time
      expect(game.seconds == 0).to eq false
    end
  end
end