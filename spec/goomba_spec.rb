require 'spec_helper'
require 'core/goomba'

describe Goomba do

  let(:game) do
    Game.new
  end

  let(:map) do
    Map.new(Game.new)
  end

  let(:goomba) do
    Goomba.new(Game.new, 100, 150, map)
  end

  describe "#initialize" do
    it "on given coordinates" do
      expect(goomba.x == 100).to eq true
      expect(goomba.y == 150).to eq true
    end

    it "with default width" do
      expect(goomba.width == 35).to eq true
    end

    it "going left" do
      expect(goomba.direction == :left).to eq true
    end

    it "alive status" do
      expect(goomba.dead == false).to eq true
    end
  end

=begin
  describe "#update" do
    it "changes frame" do
      frame = goomba.frame
      goomba.update
      expect(goomba.frame == frame).to eq false
    end
  end
=end
end