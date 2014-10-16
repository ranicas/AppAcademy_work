def times_two(array)
  array.map {|i| i*2}
end

class Array
  def my_each(&block)
    i = 0
    while self[i]
      yield self[i]
      i += 1
    end
    self
  end  
end

return_value = [1, 2, 3].my_each do |num|
  puts num
end.my_each do |num|
  puts num
end

def median(ary)
 ary.sort!
 if ary.length % 2 != 0
   ary[ary.length / 2]
 else
   mid=ary.length / 2
   (ary[mid - 1] + ary[mid]) / 2.0
 end  
end

def concatenate(ary)
  ary.inject(:+)
end

