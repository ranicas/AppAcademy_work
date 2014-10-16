class Tile
  NEIGHBORS = [
    [ -1,-1],
    [ -1, 0],
    [ -1, 1],
    [ 0, -1],
    [ 0, 1],
    [ 1, -1],
    [ 1, 0],
    [ 1, 1]
  ]

  attr_accessor :bomb, :flagged, :revealed, :position, :num_bomb

  def initialize board
    @bomb = false
    @flagged = false
    @revealed = false
    @board = board

  end

  def display_tile
    if @flagged == true
      print "F"
    elsif @revealed == false
      print "*"
    elsif @revealed == true
      print print_revealed_tile
    end
  end

  def reveal_tile
    self.revealed = true
    self.num_bomb = neighbor_bomb_count
    if num_bomb == 0
      reveal_neighbors
    end
  end


  def flag_toggle
    unless @revealed 
      @flagged = (@flagged ? false : true)
    end
  end
  
  private
  def find_neighbors
    neighbors = []
    x, y = position

    NEIGHBORS.each do |dir|
      x_new = x + dir[0]
      y_new = y + dir[1]

      next unless (0..8).cover?(x_new) && (0..8).cover?(y_new)
      neighbors << @board.board[x_new][y_new]
    end
    
    neighbors
  end
  

  def neighbor_bomb_count
    neighbors = find_neighbors
    bomb_count = 0

    neighbors.each do |tile|
      bomb_count += 1 if tile.bomb
    end

    bomb_count
  end
  
  def print_revealed_tile
    return "B" if @bomb == true

    if num_bomb == 0
      "_"
    else
      "#{num_bomb}"
    end
  end
  
  def reveal_neighbors
    
    neighbors = find_neighbors

    neighbors.each do |tile|
      next if tile.revealed
      tile.reveal_tile
    end
  end
end
