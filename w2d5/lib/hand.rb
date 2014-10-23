require_relative 'card'

class Hand


  VALUE_STRINGS = {
    :two => 2,
    :three => 3,
    :four  => 4,
    :five  => 5,
    :six   => 6,
    :seven => 7,
    :eight => 8,
    :nine  => 9,
    :ten   => 10,
    :jack  => 11,
    :queen => 12,
    :king  => 13,
    :ace   => 14
  }

  METHODS = [
  	"straight_flush",
  	"fours",
  	"full_house",
  	"flush",
  	"straight",
  	"threes",
  	"pairs"
  ]


	def initialize(hand)
		@hand = hand
	end

	def pairs
		same_kind(2)
	end

	def threes
		same_kind(3)
	end

	def straight
		card_number = convert_hand_to_num

		4.times { |i| return [] unless card_number[i] - 1 == card_number[i + 1] }

		[card_number[0]]
	end

	def flush
		suits = []
		@hand.each { |card| suits << card.suit } 

		suits.uniq.count > 1 ? [] : [convert_hand_to_num[0]]
	end

	def full_house
		(threes.empty? || pairs.empty?) ? [] : [threes[0], pairs[0]] 

	end

	def fours
		same_kind(4)
	end

	def straight_flush
		(straight.empty? || flush.empty? ? [] : [convert_hand_to_num[0]])
	end

	def beat_hand?(opponent_hand)
		self_score, opponent_score = [], []

		METHODS.each do |m|
			self_score = self.send(m)
			opponent_score = opponent_hand.send(m)

			break if !self.send(m).empty? || !opponent_hand.send(m).empty?
		end

		if self_score.empty? 
			false
		elsif opponent_score

	end

	def count
		@hand.count
	end

	private



	def convert_hand_to_num
		@hand.map { |card| VALUE_STRINGS[card.value] }.sort.reverse
	end

	def same_kind(num)
		counter, same_kind  = Hash.new(0), []

		@hand.each { |card| counter[card.value] += 1 }
		counter.select { |key, val| same_kind << VALUE_STRINGS[key] if val == num }

		same_kind.sort.reverse
	end	
end

