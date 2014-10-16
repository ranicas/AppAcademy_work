def caesar(str, num = 0)
  alpha = ('a'..'z').to_a
  ary = str.split("")
  caesar_ary = []
  ary.each do |letter|
    i = (alpha.index(letter) + num) % 26

    caesar_ary.push(alpha[i])
  end
  caesar_ary.join("")
end

p caesar("hellowxyz", 3)
