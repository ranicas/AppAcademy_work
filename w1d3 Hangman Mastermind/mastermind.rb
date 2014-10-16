class Code
  attr_reader :pattern
  COLORS = [:R, :G, :B, :Y, :O, :P]

  def initialize(pattern)
    @pattern = pattern
  end

  def self.random
    pattern = []
    
    4.times { pattern << COLORS.sample }
    
    Code.new(pattern)
  end

  def find_matches(guess)
    code_copy = @pattern.map { |i| i }
    exact = exact_matches(guess, code_copy)
    near = near_matches(guess, code_copy)

    [exact, near]
  end

  def exact_matches(guess, code_copy)
    matches = 0

    guess.each_with_index do |color, i|
      if color == @pattern[i]
        matches += 1
        code_copy.delete_at(code_copy.index(color))
      end
    end
    
    matches
  end

  def near_matches(guess, code_copy)
    matches = 0

    guess.each_with_index do |color, i|
      if color != @pattern[i] && code_copy.include?(color)
        code_copy.delete_at(code_copy.index(color))
        matches += 1
      end
    end

    matches
  end


end

class Game
  class GameError < StandardError; end

  def initialize
    @code = Code.random
  end

  def parse(str)
    str.upcase.split("").map(&:to_sym)
  end

  def run
    exact_match = 0
    turns = 0
    
    puts "MASTERMIND\n...........\n"
    until exact_match == 4 || turns == 10
      exact_match, near_match =  @code.find_matches(get_guess)
      puts "Exact Matches: #{exact_match}\nNear Matches: #{near_match}"
      turns += 1
    end
    
    puts exact_match == 4 ? "YOU WON!" : "YOU SUCK!"
  end

  def get_guess
    begin
      puts "Enter a color code: "
      guess = parse(gets.chomp)
      raise GameError unless valid_code?(guess)
    rescue GameError
      puts "Invalid Code. Color choices are #{Code::COLORS.join('')}, please pick 4"
      retry
    end
    
    guess
  end

  def valid_code?(guess)
    return false if guess.count != 4
    guess.all? { |color| Code::COLORS.include?(color) }
  end

end

Game.new.run