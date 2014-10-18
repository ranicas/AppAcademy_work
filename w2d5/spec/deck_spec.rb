require 'card'
require 'deck'

describe Deck do 
	subject(:deck) {Deck.new}
	
	describe "::all_cards" do 

		it 'should deal 52 cards' do
			expect(Deck.all_cards.count).to eq(52)
		end

		it 'should have not have any duplicates' do
			dup_deck = []
			Deck.all_cards.each do |card|
				dup_deck << [card.suit, card.value] unless dup_deck.include?([card.suit, card.value])
			end
			expect(dup_deck.count).to eq(52)
		end

	end

	describe '#initialize' do

		it 'should start with 52 cards' do 
			expect(deck.count).to eq(52)
		end		
	end

	describe '#shuffle' do 

		it 'should shuffle the deck' do
			expect(deck.shuffle).to_not eq(deck)
		end
	end

	describe '#take' do 

		it 'should reduce the deck by the number of cards' do
			before_count = deck.count
			deck.take(2)
			expect(deck.count).to eq(50)

		end
	end
end