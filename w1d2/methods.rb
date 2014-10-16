class Rps
  class InputError < StandardError;end
  MOVES = %w{Rock Scissors Paper}
  def initialize
    @computer_move_index = rand(3)
  end

  def play

    begin
      puts "Pick Rock, Paper, or Scissors"
      your_move = gets.chomp
      validate_choice(your_move)
    rescue InputError => error
      puts error
      retry
    end

    your_move_index = MOVES.index(your_move)

    computer_move = MOVES[@computer_move_index]

    game_outcome(your_move_index)

  end

  def validate_choice(your_move)
    unless MOVES.include?(your_move)
      raise InputError.new "Must choose Rock, Paper, or Scissors"
    end
  end

  def game_outcome(your_move_index)
    computer_move = MOVES[@computer_move_index]

    if @computer_move_index == (your_move_index + 1) % 3
      puts "#{computer_move}, you win!"
    elsif @computer_move_index == your_move_index - 1
      puts "#{computer_move}, you lose!"
    else
      puts "#{computer_move}, draw!"
    end
  end
end

Rps.new.play

# puts rps("Rock")
# puts rps("Paper")
# puts rps("Scissors")

def remix(choices)

  alcohols = choices.map(&:first).shuffle
  mixers = choices.map(&:last).shuffle!

  mix(alcohols, mixers)

end




def mix(alcohols, mixers)
  pairs = []

  alcohols.each_index do |i|
    pairs.push([alcohols[i], mixers[i]])
  end

  pairs
end

# p remix([
#   ["rum", "coke"],
#   ["gin", "tonic"],
#   ["scotch", "soda"]
# ])

