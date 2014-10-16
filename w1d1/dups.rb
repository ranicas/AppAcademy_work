class Array
  def my_uniq
    new_arr = []
    self.each do |element|
      next if new_arr.include?(element)
      new_arr.push(element)
    end
    new_arr
  end
end

