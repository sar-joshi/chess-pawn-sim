require "rails_helper"

describe PawnGameService do
  let(:game) { PawnGame.create! }
  let(:service) { described_class.new(game) }

  describe "#run" do
    context "when PLACE command is given" do
      it "should place pawn at valid position" do
        service.run("PLACE 1,2,NORTH,WHITE")
        game.reload

        expect(game.xpos).to eq(1)
        expect(game.ypos).to eq(2)
        expect(game.facing).to eq("NORTH")
        expect(game.colour).to eq("WHITE")
      end

      it "should ignore out of bound position" do
        service.run("PLACE 8,8,NORTH,WHITE")

        expect(game.xpos).to be_nil
        expect(game.ypos).to be_nil
      end
    end

    context "when MOVE command is given" do
      before do
        service.run("PLACE 2,2,EAST,BLACK")
      end

      it "should default to 1 step when steps not provided" do
        service.run("MOVE")
        game.reload

        expect(game.xpos).to eq(3)
        expect(game.ypos).to eq(2)
      end

      it "should allow initial move to 2 steps at max" do
        service.run("MOVE 5")
        game.reload

        expect(game.xpos).to eq(4) # only 2 steps allowed, not 5
      end

      it "should limit subsequent moves to only 1 step" do
        service.run("MOVE 1")
        service.run("MOVE 2")
        game.reload

        expect(game.xpos).to eq(4) # 2+1+1
      end
    end

    context "when Rotation command is given" do
      before do
        service.run("PLACE 3,4,NORTH,BLACK")
      end

      it "should rotate LEFT" do
        service.run("LEFT")
        game.reload

        expect(game.facing).to eq("WEST")
      end

      it "should rotate RIGHT" do
        service.run("RIGHT")
        game.reload

        expect(game.facing).to eq("EAST")
      end

      it "should handle multiple rotations" do
        service.run("RIGHT\nLEFT")
        game.reload

        expect(game.facing).to eq("NORTH")
      end
    end

    context "edge cases" do
      it "should ignore commands before PLACE" do
        service.run("MOVE\nLEFT\nPLACE 0,0,NORTH,WHITE")
        game.reload

        expect(game.xpos).to eq(0)
        expect(game.ypos).to eq(0)
        expect(game.history.length).to eq(1)
      end

      it "should normalise commands with whitespaces" do
        service.run(" PLACE 0 , 0 , NORTH , WHITE  ")
        game.reload
        expect(game.xpos).to eq(0)
        expect(game.ypos).to eq(0)
      end

      it "should normalise lowercase commands" do
        service.run(" place 0 , 0 , north , white  ")
        game.reload
        expect(game.facing).to eq("NORTH")
        expect(game.colour).to eq("WHITE")
      end
    end
  end
end
