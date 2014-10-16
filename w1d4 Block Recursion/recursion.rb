def range_i(first, last)
  array = []

  (first..last).each do |item|
    array << item
  end

  array
end

def range_r(first, last)
  return [] if last < first

  [first] + range_r(first + 1, last)
end

def range2(first, last)
  
  return [] if last < first
  
  range2(first, last - 1) << last 
end

# p range2(1, 3)

def recursion_1(base, exponent)
  return 1 if exponent == 0

  base * recursion_1(base, exponent - 1)

end

def recursion_2(base, n)
  return 1 if n == 0
  return base if n == 1
  
  half = recursion_2(base, n / 2)
  
  if n % 2 == 0
    half * half
  else #if n is odd, (n - 1) / 2 == n / 2
    base * half * half
  end
end

# p recursion_2(2, 256)

def deep_dup(ary)
  #return ary[0] if ary.length == 1 && !ary.is_a?(Array)
  new_ary = []

  ary.each do |el|
    new_ary << (el.is_a?(Array) ? deep_dup(ary) : el)
  end
  new_ary
end

def fibonacci(n)
  return [0, 1].take(n) if n <= 2

  # fibonacci(n - 1) => [0, 1]
  last_fibs = fibonacci(n - 1)
  last_fibs << last_fibs[-2] + last_fibs[-1]
end

# p fibonacci(1)
def binary_search(ary, target)
  return nil if (ary.last < target) || (ary.first > target)
  midpoint = (ary.length / 2)


  return midpoint if ary[midpoint] == target

  if ary[midpoint] > target
    binary_search(ary.take(midpoint), target)
  else ary[midpoint] < target
    midpoint += binary_search(ary.drop(midpoint), target)
  end

end

# array = [1, 2, 3, 4, 5, 6, 7, 8, 9]
#
# puts 'should be 2'
# p binary_search(array, 3)
#
# puts 'should be 6'
# p binary_search(array, 7)
#
# puts 'should be nil'
# p binary_search(array, 15)
#
def make_change(amount, coins = [10, 7, 1])
  return [] if amount == 0
  return nil if coins.none? { |coin| coin <= amount }

  coins = coins.sort.reverse
  best_change = nil
  coins.each_with_index do |coin, index|
    next if coin > amount
    remainder = amount - coin
      
    best_remainder = make_change(remainder, coins.drop(index))
      
    next if best_remainder.nil?
      
    this_change = [coin] + best_remainder
      
    if best_change.nil? || (this_change.count < best_change.count)
        best_change = this_change
    end    
  end
  
  best_change
end



# p make_change(14, [10, 7, 1])
# p make_change(20, [10, 7, 1])
 
 
def merge_sort(arr)
  return arr if arr.length <= 1
  mid = arr.length / 2
  left, right= arr.take(mid), arr.drop(mid)
  sorted_left, sorted_right = merge_sort(left), merge_sort(right)

  merge(sorted_left, sorted_right)
end

def merge(left, right)
  merged_ary = []

  until left.empty? || right.empty?
    merged_ary << (
    (left.first < right.first) ? left.shift : right.shift)

  end

  merged_ary + left + right
end

p merge_sort([ 6, 5, 3, 1, 8, 7, 2, 4 ])



