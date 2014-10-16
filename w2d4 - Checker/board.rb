class Board
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
    (0..7).cover?(pos[0]) && (0..7).cover?(pos[1]) &&
      self[pos].nil?
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
  
  private
  def start_pieces
    
  end
  
  def background(row, col, str)
    (row + col).odd? ? str.on_light_black : str.on_light   
  end
end