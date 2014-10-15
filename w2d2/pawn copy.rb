

class Pawn < Piece

  def initialize(pos, color, board)
    super
    @start_row = pos[0]
    @first_move = true
    @delta, @diag_deltas = find_deltas
  end

  def mark
  	"P"
  end

  def moves
    moves = []
    pos1 = shift_by(@delta[0]) 
    moves << pos1 if board.empty_space?(pos1) 

    if @first_move
      pos2 = shift_by(@delta[1]) 
      moves << pos2 if board.empty_space?(pos2) && board.empty_space?(pos1)
      @first_move = false
    end

    diag1, diag2 = shift_by(@diag_deltas[0]), shift_by(@diag_deltas[1])

    moves << diag1 if occupied_by_enemy?(diag1)
    moves << diag2 if occupied_by_enemy?(diag2)

  	moves
  end



  def find_deltas

    if @start_row == 1
      [[[1, 0],[2, 0]], [[1, 1], [1, -1]]]
    else
      [[[-1,0],[-2, 0]], [[-1, 1], [-1, -1]]]
    end

  end


end