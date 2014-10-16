class GuessNumber

  def initialize(num)
    @computer_number = rand(num)+1
    @guess_cnt = 0
    @num = num
    @win = false
  end


  def run
    pick_a_number

    until @win
      pick_a_number
    end

  end

  def high_low(num)
    case num <=> @computer_number

    when -1
      "Try Higher"
    when 1
      "Try Lower"
    when 0
      @win = true
      "You won after #{@guess_cnt} guesses!"
    end

  end

  def pick_a_number
    puts "\nGuess a number between 1 and #{@num}:"
    puts "You had #{@guess_cnt} guesses."
    @guess_cnt+=1
    guess = gets.chomp.to_i
    puts high_low(guess)
  end
end


# game = GuessNumber.new(10)
# game.run

class RpnCalc
  def initialize
    @calc_items = []
    @done = false
  end

  def process(input)

    if input.match(/\d+/)
      @calc_items.push(input.to_f)
    elsif input.match(/\+|-|\*|\//)
      calculate(input.to_sym)
    elsif input == "done"
      @done = true
    else
      "raise_error"
    end
  end

  def calculate(operator)

    num1 = @calc_items.pop
    num2 = @calc_items.pop

      @calc_items.push(num2.send(operator, num1))
  end

  def read_file
    path = ARGV[0]
    items_ary = File.read(path).split(/\s+/)

    items_ary.each {|item| process(item)}

    process("done")
  end

  def run
    read_file unless ARGV.empty?

    until @done
      puts "enter a number or an operator or 'done' to return the result"
      input = gets.chomp
      process(input)
    end

    puts @calc_items.last
  end

end
# calc = RpnCalc.new
# calc.run

def shuffle_file
  path = get_file

  line_ary = read_shuffle(path)

  write_file(line_ary, path)

end

def get_file
  puts "Please enter file name"
  path = gets.chomp
  p path
end

def read_shuffle(path)
  line_ary = File.readlines(path)

  line_ary.shuffle
end

def write_file(ary, path)
  File.open("#{path}-shuffled.txt", "w") do |f|
    ary.each {|line| f.puts line}
  end
end

#shuffle_file

