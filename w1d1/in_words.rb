class Fixnum
  def in_words
    num = self
    num_string = ""
    num_hash = {
      0 => 'zero',
      1 => 'one',
      2 => 'two',
      3 => 'three',
      4 => 'four',
      5 => 'five',
      6 => 'six',
      7 => 'seven',
      8 => 'eight',
      9 => 'nine',
      10 => 'ten',
      11 => 'eleven',
      12 => 'twelve',
      13 => 'thirteen',
      14 => 'fourteen',
      15 => 'fifteen',
      16 => 'sixteen',
      17 => 'seventeen',
      18 => 'eighteen',
      19 => 'nineteen',
      20 => 'twenty',
      30 => 'thirty',
      40 => 'forty',
      50 => 'fifty',
      60 => 'sixty',
      70 => 'seventy',
      80 => 'eighty',
      90 => 'ninety',
      100 => 'hundred'      
    }
    
    if num > 1000
      thousands = num/1000
      num -= thousands * 1000
      num_string += num_hash[thousands] + " thousand "
    end

    if num > 100
      hundreds = num/100
      num -= hundreds*100
      num_string += num_hash[hundreds] + " hundred "
    end
    
    #puts num_string," ",num
    if num > 20
      ones = num % 10
      num -= ones
      num_string += num_hash[num] + " " 
      num_string += num_hash[ones] if ones > 0
    end
          
    if num < 19 && num >= 0
      num_string += num_hash[num]
    end
    
    num_string
  end
end 

puts 312.in_words
=begin


  
  def thousand
  end
  def hundred()
    hundred = ""
    if num < 19 && num >= 0
      hundred = num_hash(num)
    elsif num <= 100
      ones = num % 10
      balance = num - ones
      hundred = num_hash[balance] + " " + num_hash[ones]
    end
    return hundred
  end
  def tens
  end
end
=end