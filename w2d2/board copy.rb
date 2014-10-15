require_relative 'pieces'

class Board
  # PIECE_TYPES = {
  #   :rook => Rook.new
  # }

  attr_accessor :grid #test

  def initialize
    @grid = Array.new(8) {Array.new(8)}
    #pieces in here
    start_pieces
  end

  def [](pos)
    x, y = pos[0], pos[1]
    @grid[x][y]
  end

  def []=(pos, piece)
    raise "Already has piece there!" unless empty_space?(pos)

    x, y = pos[0], pos[1]
    @grid[x][y] = piece
  end

  def empty_space?(pos)
    self[pos].nil?
  end

  def start_pieces
    place_piece(Rook, :red, [0, 0])
    place_piece(Rook, :red, [0, 7])
    place_piece(Rook, :blue, [7, 0])
    place_piece(Rook, :blue, [7, 7])

    place_piece(Bishop, :red, [0, 2])
    place_piece(Bishop, :red, [0, 5])
    place_piece(Bishop, :blue, [7, 2])
    place_piece(Bishop, :blue, [7, 5])

    place_piece(Knight, :red, [0, 1])
    place_piece(Knight, :red, [0, 6])
    place_piece(Knight, :blue, [7, 1])
    place_piece(Knight, :blue, [7, 6])

    place_piece(Queen, :red, [0, 3])
    place_piece(King, :red, [0, 4])
    place_piece(Queen, :blue, [7, 3])
    place_piece(King, :blue, [7, 4])

    place_piece(Pawn, :blue, [6, 2])
    place_piece(Pawn, :blue, [6, 3])
    place_piece(Pawn, :red, [4, 3])

  end

  def place_piece(piece, color, pos)
    self[pos] = piece.new(pos, color, self)
  end

  def display
    #top line

    @grid.each_with_index do |array, row|
      puts
      print "#{(7 - row + 1)} "
      array.each_index do |col|
        if empty_space?([row, col])
          print "[ ]"
        else
          print "[#{self[[row, col]].display_piece}]"
        end

      end
    end
    puts "\n   A  B  C  D  E  F  G  H  "
  end

  #move piece out of a grid, set to nil
end


