require 'card'

class Deck

	def self.all_cards 
		deck = []

		Card.suits.each do |suit|
			Card.values.each do |value|
				deck << Card.new(suit, value)
			end
		end

		deck
	end

	attr_reader :deck

	def initialize(deck = Deck.all_cards)
		@deck = deck
	end

	def count
		@deck.count
	end

	def shuffle
		@deck.shuffle
	end

	def take(num)
		taken_card = []
		
		num.times do 
			taken_card << @deck.shift
		end

		taken_card
	end

end