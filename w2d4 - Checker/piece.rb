class InvalidMoveError < StandardError ;end

class Piece
  DOWN = [[1, -1], [1, 1]]
  UP =  [[-1, -1], [-1, 1]]
  
  attr_reader :color, :pos, :is_king
  
  def initialize(color, pos, board, is_king = false)
    @color = color
    @pos = pos
    @board = board 
    @is_king = is_king
  end
    
  def display_piece
    mark.encode('utf-8').colorize(color)
  end
  
  def perform_moves(seq)
    unless (valid_move_seq?(seq) && perform_moves!(seq))
      raise InvalidMoveError.new("Move sequence not allowed!")
    end
  end
  
  def jump_allowed
    jumps = []
    
    move_dir.each do |dir|
      enemy_pos, jump_pos = move_by(dir), move_by([dir[0] * 2, dir[1] * 2])
      jumps << jump_pos if @board.empty_pos?(jump_pos) && 
        !@board[enemy_pos].nil? && @board[enemy_pos].color != color    
    end
    
    jumps
  end
  
  
  def slide_allowed
    moves = []
    
    move_dir.each do |dir|
      moves << move_by(dir)
    end
    
    moves.select {|position| @board.empty_pos?(position)}
  end
  
  protected
  
  def perform_moves!(move_sequence)    
    if move_sequence.count == 1
      perform_jump(move_sequence[0]) || perform_slide(move_sequence[0])
    else
      move_sequence.count.times do |i|
        return false unless perform_jump(move_sequence[i])
      end
      true
    end
  end

  private
  
  def perform_jump(new_pos) 
    dir = jump_dir(new_pos)
    return false if dir.empty?
  
    enemy_pos = move_by(dir[0])  
    return false if @board.empty_pos?(enemy_pos) ||
      @board[enemy_pos].color == color
    
    update_piece(new_pos)
    @board[enemy_pos] = nil
    
    true
  end
  
  def jump_dir(new_pos)
    delta = [new_pos[0] - pos[0], new_pos[1] - pos[1]]
    move_dir.select {|dir| [dir[0] * 2, dir[1] * 2] == delta}
  end
  
  def perform_slide(new_pos)
    if slide_allowed.include?(new_pos)
      update_piece(new_pos)
      return true
    end
    
    false
  end
  
  def valid_move_seq?(seq)
    dup_board = @board.dup
    dup_board[pos].perform_moves!(seq)
  end
  
  def mark
    if color == :white && @is_king
      "⬜"
    elsif color == :white && !@is_king
      "\u26AA"
    elsif color == :black && @is_king
      "⬛"
    else
      "\u26AB"
    end
  end
  
  def move_by(dir)
    [pos[0] + dir[0], pos[1] + dir[1]]
  end
  
  def update_piece(new_pos)
    @board[new_pos] = self
    @board[pos] = nil
    @pos = new_pos 
    maybe_promote
  end
  
  def move_dir
    return DOWN + UP if @is_king
   
    color == :white ? DOWN : UP
  end
  
  def maybe_promote
    if (color == :white && pos[0] == 7) ||
      (color == :black && pos[0] == 0)
      @is_king = true
    end     
  end
end
