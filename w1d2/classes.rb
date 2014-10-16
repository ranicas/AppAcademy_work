class Student

  attr_reader :first_name, :last_name

  def initialize(first_name, last_name)
    @first_name = first_name
    @last_name = last_name
    @courses = []
  end

  def name
    "#{first_name} #{last_name}"
  end

  def courses
    @courses.map { |course| course.name }
  end

  def enroll(course)
    return if @courses.include?(course)
    
    @courses << course
    course.add_student(self)
    
  end

  def course_load
    load_per_dept = Hash.new(0)

    @courses.each do |course|
      load_per_dept[course.dept] += course.credits
    end

    load_per_dept
  end
end

class Course

  attr_reader :name, :dept, :credits

  def initialize(name, dept, credits)
    @name = name
    @dept = dept
    @credits = credits
    @students = []
  end

  def students
    @students.map { |student| student.name }
  end

  def add_student(student)
    unless @students.include?(student)
      @students << student
      student.enroll(self)
    end
  end

end
#
# # mary = Student.new("Mary", "Oliver")
# # scooby = Student.new("Scooby", "Doo")
# # shaggy = Student.new("Shaggy", "G")
# #
# # math = Course.new("Math", :Science, 4)
# # art = Course.new("Art", :Art , 4)
# # physics = Course.new("Physics", :Science, 5)
# #
# # scooby.enroll(math)
# # scooby.enroll(physics)
# # scooby.enroll(art)
# # mary.enroll(physics)
# # shaggy.enroll(math)
# # puts scooby.course_load
# # puts mary.course_load
# # puts shaggy.course_load
# # p scooby.courses
# # p mary.courses
# # p shaggy.courses
# # p math.students
# # p art.students
# # p physics.students
#
class Board
  def initialize
    @board = Array.new(3) {Array.new(3)}
  end

  def winner
    (@board + cols + diagonals).each do |triple|
      return :x if triple == [:x, :x, :x]
      return :o if triple == [:o, :o, :o]
    end
    
    nil
  end
  
  def won?
    !winner.nil?
  end
  
  def cols
    cols = [[],[],[]]
    @board.each do |row|
      row.each_with_index do |mark, col_idx|
        cols[col_idx] << mark
      end 
    end
    
    cols
  end
  
  def diagonals
    down_diag = [[0, 0], [1, 1], [2, 2]]
    up_diag = [[0, 2], [1, 1], [2, 0]]

    [down_diag, up_diag].map do |diag|
      diag.map { |x, y| @rows[x][y] }
    end
  
  def over?()
    @board.all? do |row|
     row.all? do |item|
       !item.nil?
     end
    end
  end
  

  def empty?(pos)
    @board[pos[0]][pos[1]].nil?
  end

  def place_mark(pos, mark)
    raise "place taken" if !empty?(pos)
    
    @board[pos[0]][pos[1]] = mark
  end

end

# @rows = [
#   [:x, :o, nil],
#   [:o, :x, :o],
#   [:x, :o, :o]
# ]
# p over?(@rows)

class Game
  attr_reader :board, :players, :turn
  
  def initialize(player1, player2)
    @board = Board.new
    @players = {:x => player1, :o => player2}
    @turn = :x
  end
  
  def play
    until self.board.over?
      play_turn
    end
    
    if self.board.won?
      winning_player = self.players[self.board.winner]
      puts "#{winnning_player.name} won the game!"
    else
      puts "No one wins!"
    end
  end
  
  def show
    self.board.rows.each {|row| p row}
  end
  
  private
  def play_turn
    while true
      current_player = self.players[self.turn]
      pos = current_player.move(self, self.turn)
      
      break if place_mark(pos, self.turn)
    end
    
    @turn = ((self.turn == :x) ? :o : :x)
  end
  
  def place_mark(pos,mark)
    if self.board.empty?(pos)
      self.board.place_mark(pos, mark)
      true
    else
      false
    end
  end
end

class Player

end

class HumanPlayer < Player
  def move(game, mark)
end

class ComputerPlayer < Player

end



# hp = HumanPlayer.new("Ned")
# cp = ComputerPlayer.new
#
# TicTacToe.new(hp, cp).run
#

