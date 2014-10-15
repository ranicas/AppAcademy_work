require 'colorize'

require_relative 'pieces'
require_relative 'board'



bd = Board.new


p bd[[6, 2]].moves
p bd[[6, 3]].moves



bd.display