class Board
  COLOR = [:white, :black]
  attr_accessor :grid
  def initialize(start = true)
    @grid = Array.new(8) {Array.new(8)}
    start_pieces if start
  end
  
  def [](pos)
    @grid[pos[0]][pos[1]]
  end
  
  def []=(pos, piece)
    @grid[pos[0]][pos[1]] = piece
  end
  
  def empty_pos?(pos)
    in_bound?(pos) && self[pos].nil?
  end
  
  def display
   print "\n   0 1 2 3 4 5 6 7 " 
    8.times do |row|
      print "\n #{row} "
      8.times do |col|
        print background(row, col,
        if empty_pos?([row,col])
          "  "
        else
          "#{self[[row, col]].display_piece} "
        end )
      end
    end
    
    puts "\n\n"
  end
  
  def dup
    dup_board = Board.new(false)
    
    grid.flatten.each do |p|
      next if p.nil? 
      dup_board[p.pos]= Piece.new(p.color, p.pos, dup_board, p.is_king) 
    end
    
    dup_board
  end
  
  def in_bound?(pos)
    (0..7).cover?(pos[0]) && (0..7).cover?(pos[1])
  end
  
  def move(pos, seq)
    self[pos].perform_moves(seq)
  end
  
  def valid_piece?(pos, color)
    !self[pos].nil? && self[pos].color == color &&
      self[pos].jump_allowed + self[pos].slide_allowed != []
  end
  
  def win?(color)
    enemy_color = (color == :white ? :black : :white)
  
    return false if team(color).empty?
    team(enemy_color).empty? || no_moves_left(enemy_color)
  end
  
  private
  
  def background(row, col, str)
    (row + col).odd? ? str.on_light_black : str.on_light_yellow
  end
  
  def no_moves_left(color)
    team(color).all? { |p| p.jump_allowed + p.slide_allowed == [] }
  end
  
  def start_pieces
    COLOR.each { |color| place_team(color) }
  end
  
  def place_team(color)
    rows = (color == :white ? (0..2) : (5..7))
  
    rows.each do |row|
      8.times do |col|
        next if (row + col).even?
        self[[row, col]] = Piece.new(color, [row, col], self)
      end
    end

  end
  
  def team(color)
    grid.flatten.select { |p| p.color == color unless p.nil? }
  end
end