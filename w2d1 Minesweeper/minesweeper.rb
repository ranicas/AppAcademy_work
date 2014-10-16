require './tile.rb'
require './board.rb'
require 'yaml'

class Game

  class InputError < StandardError  ; end

  def initialize(board = Board.new)
    @board = board
  end

  def play
    until @board.game_lost? || @board.game_won?
      @board.display_board
      action = get_action
      do_action(action)
      if action == 's'
        puts "Game Saved. To reload this game later, type 'Game.new YAML.load_file('minesweeper123.txt') ' " 
        return
      end
    end

    p (@board.game_lost? ? "You Lose." : "YOU WIN!!!!!")
  end

  private
  def do_action(action)
    if action == 's'
      save
    else
      coordinates = get_coord
      @board.move(action, coordinates)
    end
  end
  
  def get_action
    begin
      puts "Please type 'r' to reveal a tile or 'f' to flag/unflag a tile. (Or 's' to save.)"
      action = gets.chomp
      raise InputError unless valid_action?(action)
    rescue InputError 
      puts "Please type 'r', 'f' or 's'!"
      retry
    end

    action
  end

  def get_coord
    begin
      puts "Which tile? Enter the coordinates e.g.: x, y"
      coordinates = gets.chomp.split(", ").map(&:to_i)
      raise InputError unless @board.valid_coord?(coordinates)
    rescue InputError 
      puts "Please enter coordinates as 'x, y' where x and y are between 1 and 9."
      retry
    end

    coordinates.map { |num| num - 1 }
  end


  def save 
    File.open("minesweeper123.txt", "w") do |f|
      f.puts(@board.to_yaml)
    end
  end
  
  def valid_action?(action)
    return true if (action == 'r') || (action == 'f') || (action == 's')

    false
  end

end




b1 = Game.new(YAML.load_file('minesweeper123.txt'))
b1.play

