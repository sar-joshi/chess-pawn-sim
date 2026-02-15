# todo
require 'rails_helper'

describe Pawn do
  let(:pawn) { Pawn.new(0, 0, "NORTH", "WHITE") }

  describe '#soft_move' do
    it "should calculate correct position based on given facing" do
      new_position = pawn.soft_move(1)
      expect(new_position).to eq({ x: 0, y: 1 })
    end

    it "should move South when facing South" do
      pawn = Pawn.new(0, 5, "SOUTH", "WHITE")
      expect(pawn.soft_move(1)).to eq({ x: 0, y: 4 })
    end

    it "should not mutate pawn's internal state" do
      pawn.soft_move(1)
      expect(pawn.y).to eq(0)
    end
  end

  # descibe "#rotate" do
  # end
end
