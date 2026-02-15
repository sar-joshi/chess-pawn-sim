# todo
require 'rails_helper'

describe Pawn do
  let(:pawn) { Pawn.new(0, 0, "NORTH", "WHITE") }

  describe '#soft_move' do
    it "should calculate correct position when facing North" do
      pawn = Pawn.new(0, 0, "NORTH", "WHITE")
      new_position = pawn.soft_move(1)
      expect(new_position).to eq({ x: 0, y: 1 })
    end

    it "should move South when facing South" do
      pawn = Pawn.new(0, 5, "SOUTH", "WHITE")
      expect(pawn.soft_move(1)).to eq({ x: 0, y: 4 })
    end

    it "should move East when facing East" do
      pawn = Pawn.new(2, 3, "EAST", "WHITE")
      expect(pawn.soft_move(1)).to eq({ x: 3, y: 3 })
    end

    it "should move West when facing West" do
      pawn = Pawn.new(5, 3, "WEST", "WHITE")
      expect(pawn.soft_move(1)).to eq({ x: 4, y: 3 })
    end

    it "should not mutate pawn's internal state" do
      pawn.soft_move(1)
      expect(pawn.y).to eq(0)
    end
  end

  describe "#rotate" do
    it "should correctly rotate all facings" do
      pawn = Pawn.new(0, 0, "SOUTH", "BLACK")

      pawn.rotate(:LEFT) # EAST
      pawn.rotate(:LEFT) # NORTH
      pawn.rotate(:LEFT) # WEST
      pawn.rotate(:LEFT) # SOUTH
      expect(pawn.facing).to eq(:SOUTH)
    end
  end

  describe "edge cases" do
    it "should return current position when 0 step moved" do
      pawn = Pawn.new(3, 4, "NORTH", "WHITE")
      expect(pawn.soft_move(0)).to eq({ x: 3, y: 4 })
    end

    it "should cast string cooridainates to integer" do
      pawn = Pawn.new("1", "2", "NORTH", "WHITE")
      expect(pawn.soft_move(0)).to eq({ x: 1, y: 2 })
    end
  end
end
