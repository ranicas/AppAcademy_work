class Array
  def two_sum
    pair_array = []
    (self.length - 2).times do |i|
      ((i + 1)..(self.length - 1)).each do |j|
        pair_array << [i, j] if self[i] + self[j] == 0
      end
    end
    
    pair_array
  end
end

