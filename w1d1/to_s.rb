def num_to_s(num, base)
  values = { 
    0 => "0",
    1 => "1",
    2 => "2",
    3 => "3",
    4 => "4",
    5 => "5",
    6 => "6",
    7 => "7",
    8 => "8",
    9 => "9",
    10 => "A",
    11 => "B",
    12 => "C",
    13 => "D",
    14 => "E",
    15 => "F",
  }
  pow =0
  string_num = ""
  
  until (num / (base ** pow)) == 0 do
    string_num = values[(num / (base**pow)) % base]  + string_num 
 
  pow += 1   
  
  end
  
  string_num
end

p num_to_s(234,10)
p num_to_s(234,2)
p num_to_s(234,16)