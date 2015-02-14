require 'spec_helper'
require 'core/mushroom'

describe Mushroom do

  let(:map) do
    Map.new(Game.new)
  end

  let(:mushroom) do
    Mushroom.new(Game.new, 500, 60, map)
  end

  describe "#initialize" do
    it "mushroom on coordinates" do
      expect(mushroom.x == 500).to eq true
    end

    it "mushroom width" do
      expect(mushroom.width == 30).to eq true
    end

    it "in given direction" do
      expect(mushroom.direction == :right).to eq true
    end

    it "deactivated mushroom" do
      expect(mushroom.active == false). to eq true
    end
  end
end