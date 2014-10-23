class Array
	def my_uniq
		my_uniq_ary = []

		self.each do |el|
			my_uniq_ary << el unless my_uniq_ary.include?(el)
		end

		my_uniq_ary
	end


	def two_sum
		
		[].tap do |result|
			self.each_with_index do |el, i|
				self.each_with_index do |el2, j|
					next if i >= j
					result << [i, j] if el + el2 == 0
				end
			end
		end
	end 
end

def my_transpose(matrix)
	return [] if matrix == []
	new_matrix = Array.new(matrix[0].count) { Array.new(matrix.count) }

	matrix.each_with_index do |row, i|
		row.each_with_index do |el, j|
			new_matrix[j][i] = el
		end
	end

	new_matrix
end

def stock_picker(prices)
 diff = 0
 pair = []

  prices.each_with_index do |buy, i|
  	prices.each_with_index do |sell, j|
  		next if i >= j || (sell - buy) <= diff
  		
  		diff = sell - buy
  		pair = [i, j]
  	end
  end

  pair
end
