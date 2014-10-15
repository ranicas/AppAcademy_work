require_relative 'stepping_piece'

class King < SteppingPiece

DIRECTION_DELTAS = [[1, 0], [-1, 0], [0, 1], [0, -1], [1, 1], [1, -1], [-1, 1], [-1, -1]]

  def mark
  	"K"
  end

  def move_dirs
  	DIRECTION_DELTAS
  end

  


end