def divisible(min, divisor)
  num = min

  num +=1 until num % divisor == 0

  num
end

#p divisible(250,7)

def factors(num)
  (1..num).each.select {|i| num % i == 0}
end

#p factors(252)

def bubble_sort(arr)
  sorted = false

  until sorted
    sorted = true

    (arr.length - 1).times do |i|
      if arr[i] > arr [i+1]
        arr[i], arr[i+1] = arr[i+1], arr[i]
        sorted = false
      end
    end
  end

  arr
end


#p bubble_sort([4, 5, 2, 3, 1, 6])

def substrings(string)
  substrings = []

  (0...string.length).each do |start_index|
    end_index = start_index
    (start_index...string.length).each do |end_index|
      substr = string[start_index..end_index]
      unless substrings.include?(substr)
        substrings << substr if subword(substr)
      end
    end
  end

  substrings
end

def subword(string)

  File.foreach("dictionary.txt") do |word|
    return true if word.chomp == string
  end

  false
end

p subword("aardvark")
p substrings("aardvark")
