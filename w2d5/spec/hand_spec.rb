require 'hand'
require 'card'

describe Hand do
	let(:straight_flush) do 
		straight_flush = [
			Card.new(:clubs, :three),
			Card.new(:clubs, :four),
			Card.new(:clubs, :five),
			Card.new(:clubs, :six),
			Card.new(:clubs, :seven)
		]
	end

		let(:fours_a_kind) do 
		 fours_a_kind = [
			Card.new(:clubs, :three),
			Card.new(:diamonds, :three),
			Card.new(:spades, :three),
			Card.new(:hearts, :three),
			Card.new(:clubs, :seven)
		]
	end


		let(:full_house) do 
		 full_house = [
			Card.new(:clubs, :three),
			Card.new(:diamonds, :three),
			Card.new(:spades, :three),
			Card.new(:hearts, :seven),
			Card.new(:clubs, :seven)
		]
	end

		let(:flush_cards) do 
		flush_cards = [
			Card.new(:clubs, :ace),
			Card.new(:clubs, :four),
			Card.new(:clubs, :five),
			Card.new(:clubs, :six),
			Card.new(:clubs, :seven)
		]
	end

		let(:straight) do 
		straight = [
			Card.new(:clubs, :three),
			Card.new(:diamonds, :four),
			Card.new(:clubs, :five),
			Card.new(:clubs, :six),
			Card.new(:clubs, :seven)
		]
	end

		let(:three_a_kind) do 
		 three_a_kind = [
			Card.new(:clubs, :three),
			Card.new(:diamonds, :three),
			Card.new(:spades, :three),
			Card.new(:hearts, :seven),
			Card.new(:clubs, :four)
		]
	end

		let(:two_pairs) do 
		two_pairs = [
			Card.new(:diamonds, :four),
			Card.new(:clubs, :four),
			Card.new(:clubs, :six),
			Card.new(:diamonds, :six),
			Card.new(:clubs, :seven)
		]
	end

		let(:one_pair) do 
		one_pair = [
			Card.new(:diamonds, :four),
			Card.new(:clubs, :four),
			Card.new(:clubs, :six),
			Card.new(:diamonds, :eight),
			Card.new(:clubs, :seven)
		]
	end

		let(:high_card) do 
		high_card = [
			Card.new(:clubs, :three),
			Card.new(:clubs, :king),
			Card.new(:diamonds, :nine),
			Card.new(:clubs, :six),
			Card.new(:clubs, :ace)
		]
	end

		let(:bad_hand) do 
		bad_hand = [
			Card.new(:clubs, :three),
			Card.new(:hearts, :queen),
			Card.new(:diamonds, :ten),
			Card.new(:spades, :eight),
			Card.new(:clubs, :two)
		]
	end

	subject(:hand) {Hand.new(bad_hand)}

	describe '#initialize' do
		it 'should start with 5 cards' do
			expect(hand.count).to eq(5)
		end
	end



	describe '#pairs' do
		it 'should return an empty array when there is no pairs' do
			expect(hand.pairs).to eq([])
		end

		# it 'should not return three of a kind as pairs' do

		# 	hand = Hand.new(three_a_kind)
		# 	expect(hand.pairs).to eq([])
	 #  end

		it 'should return one pair in an array' do
			hand = Hand.new(one_pair)
			expect(hand.pairs).to eq([4])
		end

		it 'should return two pairs in an array in descending order' do
			hand = Hand.new(two_pairs)
			expect(hand.pairs).to eq([6, 4])
		end
	end

	describe '#threes' do

		it 'should return an empty array when there is no threes' do
			expect(hand.threes).to eq([])
		end

		it 'should return threes in an array' do
			hand = Hand.new(three_a_kind)
			expect(hand.threes).to eq([3])
		end
	end

	describe '#straight' do

		it 'should return an empty array when there is no straight' do
			expect(hand.straight).to eq([])
		end

		it 'should detect straight and return the highest number' do
			hand = Hand.new(straight)
			expect(hand.straight).to eq([7])
		end
	end

	describe '#flush' do

		it 'should return an empty array when there is no flush' do
			expect(hand.flush).to eq([])
		end

		it 'should detect flush and return the highest number' do
			hand = Hand.new(flush_cards)
			expect(hand.flush).to eq([14])
		end
	end

	describe '#full_house' do

		it 'should return an empty array when there is no full house' do
			expect(hand.full_house).to eq([])
		end

		it 'should detect full house and return a pair, first number for threes, second for the pair' do
			hand = Hand.new(full_house)
			expect(hand.full_house).to eq([3, 7])
		end
	end

	describe '#fours' do

		it 'should return an empty array when there is no four of a kind' do
			expect(hand.fours).to eq([])
		end

		it 'should detect four of a kind and return the number' do
			hand = Hand.new(fours_a_kind)
			expect(hand.fours).to eq([3])
		end
	end

	describe '#straight_flush' do

		it 'should return an empty array when there is no straight_flush' do
			expect(hand.straight_flush).to eq([])
		end

		it 'should detect a straight flush and return the highest number' do
			hand = Hand.new(straight_flush)
			expect(hand.straight_flush).to eq([7])
		end
	end

	describe '#beat_hand?' do

		it 'should return true if the self is higher' do
			 hand1 = Hand.new(straight_flush)
			 hand2 = Hand.new(bad_hand) 
			 expect(hand1.beat_hand?(hand2)).to be true
		end

		it 'should return false if self is smaller' do
			 hand1 = Hand.new(straight_flush)
			 hand2 = Hand.new(bad_hand) 
			 expect(hand2.beat_hand?(hand1)).to be false
		end
	
	end

end