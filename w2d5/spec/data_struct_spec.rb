require 'data_struct'

describe Array do
	describe '#my_uniq' do

		it 'should return empty array' do
			expect([].my_uniq).to eq([])
		end

		it 'should return only uniq values' do 
			expect([1, 2, 3, 1, 1].my_uniq).to eq([1, 2, 3])
		end

		it 'should return a new array' do
			array = [1, 2, 3, 1, 1]
			uniq_array = array.my_uniq

			expect(array).to eq([1, 2, 3 , 1, 1])
		end
	end

	describe '#two_sum' do

		it 'should return empty array' do
			expect([].two_sum).to be_empty
		end

		it 'should return pairs of indices' do
			expect([-1, 1].two_sum).to eq([[0, 1]])
		end

		it 'should return pairs of indices in dictionary order' do
			expect([-1, -3, 1, 3].two_sum).to eq([[0, 2], [1, 3]])
		end

		it 'should allow same number with different pairing' do
			expect([1, -1, -1].two_sum).to eq([[0, 1], [0, 2]])
		end

		it 'should not return false positive' do
			expect([-1, 0, 2, -2, 1].two_sum).to eq([[0, 4], [2, 3]])
		end

	end

end

describe '#my_transpose' do

	it 'should return an empty array' do
		expect(my_transpose([])).to eq([])
	end

	it 'should handle square matrix' do
		rows = [
					    [0, 1, 2],
					    [3, 4, 5],
					    [6, 7, 8]
  					]
  	col = [
		  	    [0, 3, 6],
				    [1, 4, 7],
				    [2, 5, 8]
				  ]
		expect(my_transpose(rows)).to eq(col)
	end

	it 'should handle non-suqare matrix' do
		rows = [
				 [1, 2],
				 [3, 4],
				 [5, 6],
				 [7, 8]
  		 ]
 		col = [
		  	    [1, 3, 5, 7],
				    [2, 4, 6, 8]
				  ]
		expect(my_transpose(rows)).to eq(col)
	end
end

describe '#stock_picker' do

	it 'should be empty if no profitable days' do 
		expect(stock_picker([5, 4, 3, 2, 1])).to eq([])
	end

	it 'should return the most profitable pair of days' do
		expect(stock_picker([1, 2, 3, 4, 5])).to eq([0, 4])
	end

  it 'should return the ealiest instance when there is a tie' do
  	expect(stock_picker([1, 3, 2, 4, 4])).to eq([0, 3])
  end



end
