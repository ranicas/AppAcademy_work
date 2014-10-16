

class TowersGame
  
  def initialize(num_discs=3)
    @stacks=[(1..num_discs).to_a.reverse,[],[]]  
  end
  
  def render
    max_height = @stacks.map(&:count).max
    
    (max_height - 1).downto(0).map do |height|
      @stacks.map do |stack|
        stack[height] || " "
      end.join("\t")
    end.join("\n")
  end
  
  def display
    puts render
  end
  
  def move(from_stack_num, to_stack_num)
    from_stack, to_stack = @stacks.values_at(from_stack_num, to_stack_num)
    
    raise "cannot move from empty stack" if from_stack.empty?
    
    unless (to_stack.empty? || to_stack.last > from_stack.last)
      raise "cannot move onto smaller disk"
    end

    to_stack.push(from_stack.pop)
    self
  end

  #breaks up the logic for readability
  def game_won?
    @stacks[0].empty? && @stacks[1..2].any?(&:empty?)
  end
  
  def run
  
    until game_won?
      display
      
      from_stack_num, to_stack_num = get_move
      
      move(from_stack_num, to_stack_num)
    end
    
    puts "You did it!"
  
  end
  
  private
  def get_move
    from_stack_num = get_stack("Move from: ")
    to_stack_num = get+stack("Move to: ")
    
    [from_stack_num, to_stack_num]
  end
  
  def get_stack(prompt)
    move_hash={
end

TowersGame.new(3).run