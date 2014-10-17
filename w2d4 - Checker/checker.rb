#encoding: utf-8
require_relative 'board'
require_relative 'piece'
require 'colorize'
require 'byebug'

class InputError < StandardError ;end

class Checker
  
  def initialize
    @board = Board.new
    @current_color = :white
  end
  
  def play
    until @board.win?(:white) || @board.win?(:black)
      @board.display
      take_turn
      change_current_color
    end
    
    puts (@board.win?(:white) ? "White wins!" : "Black wins!" ).colorize(:red)
  end
  
  private 
  
  def change_current_color
    @current_color = (@current_color == :white ? :black : :white)
  end
  
  def get_move
    puts "Turn: #{@current_color}\t"
    puts "Select piece by indicating its starting position ex. 00"
    start_pos = gets.chomp.split("").map(&:to_i)
    validate_start_piece(start_pos)
    puts "Input move sequence separate by space: 00 11 22 etc"
    move_seq = gets.chomp.split.map {|str| str.split("").map(&:to_i) }
    validate_move_seq(move_seq)
    [start_pos, move_seq]
  end
  
  def take_turn
      start_pos, move_seq = get_move
      @board.move(start_pos, move_seq)
    rescue InvalidMoveError => move_err
      puts move_err
      retry
    rescue InputError => input_err
      puts input_err
      retry
  end
  
  def validate_move_seq(seq)
    seq.all? { |pos| validate_format(pos) }
  end
  
  def validate_start_piece(pos)
    validate_format(pos)
    raise InputError.new("Cannot select piece!") unless @board.valid_piece?(pos, @current_color)
  end
  
  def validate_format(pos)
    raise InputError.new("Invalid Format") unless pos.count == 2 || @board.in_bound?(pos)
  end
  
end

game = Checker.new

game.play
#  bd = Board.new
# # bd = Board.new(false)
# # pc = Piece.new(:white, [0, 0], bd)
# # bd[[0, 0]] = pc
# # p bd.win?(:white)
# # p bd.win?(:black)
#
# # pc2 = Piece.new(:white, [1, 1], bd, true)
# # bd[[1, 1]] = pc2
# # pc3 = Piece.new(:black, [2, 2], bd, true)
# # bd[[2, 2]] = pc3
# # pc4 = Piece.new(:white, [3, 3], bd)
# # bd[[3, 3]] = pc4
# # bd.display
# # bd2 = bd.dup
# # p pc4.slide_allowed
# # p pc4.perform_moves!([[4, 2]])
# # p pc3.perform_moves!([[4, 4]])
# # p pc2.pos
# # puts pc2
# # bd2.display
# # p bd[[2, 0]].valid_move_seq?([[3, 1]])
# p bd[[2, 0]].perform_moves([[3, 1]])
# # p bd[[2, 0]].valid_move_seq?([[4, 0]])
# # p bd[[2, 0]].valid_move_seq?([[3, 1], [4, 2]])
# # p bd[[3, 1]].pos
# bd.display
# # p bd[[3, 1]].slide_allowed
# # p bd[[3, 1]].valid_move_seq?([[4, 2]])
# p bd[[3, 1]].perform_moves([[4, 2]])
# bd.display
# p bd[[5, 1]].jump_allowed
# p bd[[5, 1]].perform_moves([[3, 3]])
# bd.display