class Array
  def my_each(&proc)
    i = 0

    while i < self.length
      yield self[i]
      i += 1
    end

    self
  end

  def my_map(&proc)
    i, map_ary = 0, []

    while self[i]
      map_ary << proc.call(self[i])
      i += 1
    end

    map_ary
  end

  def my_select
    i, select_ary = 0, []

    while self[i]
      select_ary <<  self[i] if yield(self[i])
      i += 1
    end

    select_ary
  end

  def my_inject(&proc)
    arg = 0
    self.my_each do |i|
      arg = proc.call(arg, i)
    end
    arg
  end

  def my_sort!(&proc)
    sorted = false
    until sorted
      sorted = true
      (self.length - 1).times do |i|
        if proc.call(self[i],self[i + 1]) == 1
          self[i], self[i + 1] = self[i + 1], self[i]
          sorted = false
        end
      end
    end
      self
  end

  def my_sort(&proc)
    dup = self.dup
    dup.my_sort!(&proc)
  end
end

def eval_block(*arg, &proc)
  unless block_given?
    puts "NO BLOCK GIVEN"
  else
    proc.call(arg)
  end
end

if __FILE__ == $PROGRAM_NAME
  # ary = [1, 2, 3, 4]
  # p ary.my_each {|i| i + 1}
  # p ary.my_map { |i| i + 1}
  # p ary.my_select { |i| i > 1 }
  # p ary.my_inject(1) {|inj, val| inj*val}
  # p ary.shuffle!.my_sort { |num1, num2| num1 <=> num2 }
  eval_block("Kerry", "Washington", 23) do |fname, lname, score|
    puts "#{lname}, #{fname} won #{score} votes."
  end

  eval_block(1,2,3,4,5) do |args|
    p args.inject(:+)
  end

  eval_block(1, 2, 3)
end
