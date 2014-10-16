class Piece
  COLOR = [:blue, :red]
  DOWN = [[1, -1], [1, 1]]
  UP =  [[-1, -1], [-1, 1]]
  
  attr_reader :color, :pos
  
  def initialize(color, pos, board, is_king = false)
    @color = color
    @pos = pos
    @board = board 
    @is_king = is_king
  end
    
  def display_piece
    mark.encode('utf-8').colorize(color)
  end
  
  def perform_slide(new_pos)
    if slide_allowed.include?(new_pos)
      update_piece(new_pos)
      return true
    end
    
    false
  end

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
  
  
  private
  
  def mark
    if color == :blue && @is_king
      "⬜"
    elsif color == :blue && !@is_king
      "\u26AA"
    elsif color == :red && @is_king
      "⬛"
    else
      "\u26AB"
    end
  end
  
  def jump_dir(new_pos)
    delta = [new_pos[0] - pos[0], new_pos[1] - pos[1]]
    move_dir.select {|dir| [dir[0] * 2, dir[1] * 2] == delta}
  end
  
  def slide_allowed
    moves = []
    
    move_dir.each do |dir|
      moves << move_by(dir)
    end
    
    moves.select {|position| @board.empty_pos?(position)}
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
   
    color == :blue ? DOWN : UP
  end
  
  def maybe_promote
    if (color == :blue && pos[0] == 7) ||
      (color == :red && pos[0] == 0)
      @is_king = true
    end     
  end
end
