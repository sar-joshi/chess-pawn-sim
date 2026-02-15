require "rails_helper"

describe Board do
  let(:board) { Board.new }

  describe "#position_in_bound?" do
    it "should return true for valid coordinates inbound" do
      expect(board.position_in_bound?(0, 0)).to be true
      expect(board.position_in_bound?(7, 7)).to be true
      expect(board.position_in_bound?(4, 2)).to be true
    end

    it "should return false for coordinates out of bound" do
      expect(board.position_in_bound?(-1, -1)).to be false
      expect(board.position_in_bound?(8, 8)).to be false
    end
  end
end
