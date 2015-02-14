require 'spec_helper'
require 'core/unit'

describe Unit do

  let(:map) do
    Map.new(Game.new)
  end

  let(:unit) do
    Unit.new(Game.new, 0, 0, map)
  end

  describe "#initialize" do
    it "unit on coordinates" do
      expect(unit.x == 0).to eq true
    end

    it "unit with default width" do
      expect(unit.width == 35).to eq true
    end

    it "unit in given direction" do
      expect(unit.direction == :right).to eq true
    end
  end

=begin # No idea why..
  describe "#update" do
    it "moves unit in given direction" do
      unit.map.tiles = Array.new(1) do |x|
        Array.new(1) do |y|
          unit.map.tiles[x][y] = '.'
        end
      end
      unit.map.tiles[0][0] = '.'
      unit.map.tiles[0][1] = '.'
      unit.map.tiles[1][0] = '.'
      x = unit.x
      unit.update
      expect(unit.x == x).to eq false
    end
  end
=end

  describe "#move_y" do
    it "changes velocity" do
      unit.map.tiles[0][0] = '.'
      unit.map.tiles[0][1] = '.'
      unit.move_y
      expect(unit.velocity == 0).to eq false
    end

    it "moves y" do
      unit.map.tiles[0][0] = '.'
      unit.map.tiles[0][1] = '.'
      y = unit.y
      unit.move_y
      expect(unit.y == y).to eq false
    end
  end
end