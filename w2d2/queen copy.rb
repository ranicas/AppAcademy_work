require_relative 'sliding_piece'


class Queen < SlidingPiece
  DIRECTION_DELTAS = [[1, 0], [-1, 0], [0, 1], [0, -1], [1, 1], [1, -1], [-1, 1], [-1, -1]]

  def move_dirs
  	DIRECTION_DELTAS
  end

  def mark
  	"Q"
  end

end