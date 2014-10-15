require_relative 'sliding_piece'


class Rook < SlidingPiece
  DIRECTION_DELTAS = [[1, 0], [-1, 0], [0, 1], [0, -1]]

  def mark
    "R"
  end

  def move_dirs
    DIRECTION_DELTAS
  end


end


# rook = Rook.new([2,3], "white", Board.new)

# p rook.moves
