#encoding: utf-8
require_relative 'board'
require_relative 'piece'
require 'colorize'

class Checker
  
  
end

bd = Board.new
pc = Piece.new(:blue, [0, 0], bd)
bd[[0, 0]] = pc
pc2 = Piece.new(:blue, [1, 1], bd, true)
bd[[1, 1]] = pc2
pc3 = Piece.new(:red, [2, 2], bd)
bd[[2, 2]] = pc3
pc3 = Piece.new(:red, [3, 3], bd, true)
bd[[3, 3]] = pc3
# p pc.moves_allowed
# p pc2.moves_allowed
# p pc3.moves_allowed
# p pc2.perform_jump([3, 3])
# p pc2.pos
# puts pc2

bd.display