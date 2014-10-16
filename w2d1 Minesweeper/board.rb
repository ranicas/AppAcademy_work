class Board
  attr_reader :board

  def initialize
    build_board
  end

  def display_board
    @board.each_with_index do |row, x|
      puts
      row.length.times do |y|
        @board[y][x].display_tile
        print " "
      end
    end

    puts "\n\n"
  end

  def game_lost?
    @board.flatten.any? do |tile|
      tile.bomb && tile.revealed
    end
  end

  def game_won?
    @board.flatten.all? do |tile|
      tile.bomb ? tile.flagged : tile.revealed 
    end
  end

  def move(action, coordinates)
    x, y = coordinates

    if action == "f"
      @board[x][y].flag_toggle
    else
      @board[x][y].reveal_tile
    end

  end
  
  def valid_coord?(coord)
    return false unless coord.count == 2

    coord.map(&:to_i).all? { |num| (1..9).cover?(num) }
  end 

  private
  def build_board
    @board = Array.new(9) { Array.new(9) { Tile.new self } }
    tell_tile_position
    place_bombs
  end

  def place_bombs
    @board.flatten.sample(10).each { |tile| tile.bomb = true }
  end
  
  def tell_tile_position
    (0..8).each do |i|
      (0..8).each do |j|
        @board[i][j].position = [i, j]
      end
    end
  end
  
end
