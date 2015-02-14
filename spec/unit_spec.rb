require 'spec_helper'
require 'core/unit'

describe Unit do

  let(:map) do
    Map.new(Game.new)
  end

  let(:unit) do
    Unit.new(Game.new, 60, 60, map)
  end

  describe "#initialize" do
    it "unit on coordinates" do
      expect(unit.x == 60).to eq true
    end

    it "unit with default width" do
      expect(unit.width == 35).to eq true
    end

    it "unit in given direction" do
      expect(unit.direction == :right).to eq true
    end
  end

# Can't initialize a proper map
=begin
  describe "#update" do
    it "moves unit in given direction" do
      x = unit.x
      unit.update
      expect(unit.x == x).to eq false
    end
  end

  describe "#move_y" do
    it "changes velocity" do
      velocity = unit.velocity
      unit.move_y
      expect(unit.velocity == velocity).to eq false
    end
  end
=end
end