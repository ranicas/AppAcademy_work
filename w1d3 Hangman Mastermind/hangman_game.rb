class Hangman

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
  end

  def play
    turn = 0
    length = @player1.get_secret_word_length
    @gameboard = GameBoard.new(length)
    
    @player2.receive_board(@gameboard)
    until @gameboard.won? || turn == 6
      @gameboard.display
      @gameboard.update_board(
        @player1.check(@player2.guess)
      )
      turn += 1
    end

    @gameboard.game_over
  end
end

class GameBoard
  attr_reader :word, :wrong_guesses

  def initialize(word_length)
    @word = Array.new(word_length, "_")
    @wrong_guesses = []
  end

  def display
    puts "Secret word: #{@word.join}"
    puts "Wrong Guesses: #{@wrong_guesses.join(" ")} "
  end

  def game_over
    puts @word.include?("_") ? "Ran out of guesses" : "Player 2 wins!"
  end

  def update_board(data)
    letter, indices = data
    
    @wrong_guesses << letter if indices.empty?
    
    indices.each { |i| @word[i] = letter }
  end

  def won?
    !@word.include?("_")
  end
end



class Player

  class GameError < StandardError; end
end

class HumanPlayer < Player

  def get_secret_word_length
    puts "How long is your word?"
    length = Integer(gets.chomp)
  end

  def guess
    get_letter
  end

  def get_number
    begin
      puts "Enter length of word: "
      number = gets.chomp
      raise GameError if !valid_number?(number)
    rescue GameError
      puts "Pick a number!"
      retry
    end

    number
  end

  def get_letter
    begin
      puts "Guess a letter: "
      letter = gets.chomp.downcase
      raise GameError if !valid_letter?(letter)
    rescue GameError
      puts "Pick a letter!"
      retry
    end

    letter
  end


  def valid_letter?(guess)
    return false if guess.length > 1
    guess.match(/[a-zA-Z]/)
  end

  def valid_number?(guess)
    guess.match(/\d+/)
  end

  def check(guess)
    puts "\nFor which positions is \"#{guess}\" a match? 
          \nSeparate by space, 0 means no match."
    indices = gets.chomp.split(" ").map { |i| i.to_i - 1 }
    indices = [] if indices.include?(-1)
    
    [guess, indices]
  end

  def receive_board(board)
    puts "The secret word is #{length} letters long!"
  end
end

class ComputerPlayer < Player
  attr_reader :gameboard

  def receive_board(gameboard)
    @gameboard = gameboard
    @length = @gameboard.word.length
  end

  def initialize
    @dictionary = dictionary
  end

  def dictionary
    File.readlines('dictionary.txt').map(&:chomp)
  end

  def get_secret_word_length
    @secret = @dictionary.sample.split("")
    @secret.length
  end

  # def get_input(type)
 #    ("a".."z").to_a.sample
 #  end

  def guess
    @guesser = @guesser || Guesser.new(@dictionary, @length, @gameboard)
    @guesser.run
  end

  def check(guess)
    indices = @secret.each_index.select { |i| @secret[i] == guess }
    [guess, indices]
  end
end

class Guesser

  def initialize(dictionary, length, gameboard)
    @word_bank = dictionary.select! { |word| word.length == length }
    @gameboard = gameboard
  end

  def most_used_letter
    letter_frequency = Hash.new { |h, k| h[k] = 0}

    @word_bank.each do |word|
      word.each_char do |char|
        letter_frequency[char] += 1
      end
    end

    letters = letter_frequency.sort_by { |key, value| value }
    letter = letters[-1][0]
    i = -2
   
    while @gameboard.word.include?(letter)
      letter = letters[i][0]
      i -= 1
    end

    letter
  end

  def trim_bank
    trim_by_wrong_letter unless @gameboard.wrong_guesses.nil?
    trim_by_right_letter
  end

  def trim_by_wrong_letter
    unless @gameboard.wrong_guesses.empty?
      letter = @gameboard.wrong_guesses.last
      @word_bank.select! { |word| !word.include?(letter) }
    end
  end

  def trim_by_right_letter
    @gameboard.word.each_with_index do |letter, i|
      next if letter == "_"
      @word_bank.select! do |str|
        str[i] == letter
      end
    end
  end

  def run
    trim_bank
    most_used_letter
  end


end

p1 = HumanPlayer.new
p2 = ComputerPlayer.new
Hangman.new(p1,p2).play
