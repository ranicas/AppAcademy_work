require_relative  'piece'

class SteppingPiece < Piece

  def moves
    moves = []

    move_dirs.each do |delta|
      shift = delta
      next unless in_bounds?(shift) && board.empty_space?(shift_by(shift))
      moves << shift_by(shift)
    end

    moves
  end

end