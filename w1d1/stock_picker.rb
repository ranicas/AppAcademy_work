def stock_picker(ary) 
  dif=0
  buy=0
  sell=0
  ary.length.times do |i|
    ((i+1)..(ary.length-1)).each do |j|
      if (ary[j]-ary[i])>dif
        dif=ary[j]-ary[i]
        buy=i
        sell=j
      end
    end
  end
  [buy,sell]
end

p stock_picker([1,2,3,4,5])
p stock_picker([1,2,3,4,0,5])
