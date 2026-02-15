
class Board < ApplicationRecord
  SIZE = 8 # board dimension

  # Check if Pawn's position is within the board boundaries.
  def position_in_bound?(x, y)
    # minimum and maximum distance a pawn can travel on the board
    range = 0..(SIZE - 1)

    range.cover?(x) && range.cover?(y)
  end
end
