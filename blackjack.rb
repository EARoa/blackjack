class Card

  attr_accessor :suit, :value

  def initialize(suit, value)
    @suit = suit
    @value = value
  end

  def value
    if ["J", "Q", "K"].include? @value
      return 10
    elsif @value == "A"
      return 11
    else
      return @value
    end
  end

  def to_s
    [suit,value].join('-')
  end
end

class Hand
  attr_accessor :cards

  def initialize
    @cards = []
  end

  def new_card(card)
    @cards << card
  end

  def value
    total = 0
    @cards.each do |card|
      total += card.value
    end
    total
  end
end

class Deck
  attr_accessor :cards

  def initialize
    @cards = []

    suits = [:hearts, :diamonds, :spades, :clubs]
    suits.each do |suit|
      (2..10).each do |value|
        @cards << Card.new(suit, value)
      end
      @cards << Card.new(suit, "J")
      @cards << Card.new(suit, "Q")
      @cards << Card.new(suit, "K")
      @cards << Card.new(suit, "A")
    end

    @cards.shuffle!

  end

  def deal
    @cards.shift
  end

end


deck = Deck.new


puts "Welcome to BlackJack. Best of luck."

player_hand = Hand.new
dealer_hand = Hand.new

2.times do
  player_hand.new_card(deck.deal)
  dealer_hand.new_card(deck.deal)
end

puts "Your cards are: #{player_hand.cards.join(" ")}"
puts "Dealer's cards: #{dealer_hand.cards.first}"

puts "Hit or Stay? (h/s)"
choice = gets.chomp

until player_hand.value > 21 || choice == "s"

if choice == "h"
  player_hand.new_card(deck.deal)
else choice == "s"
  puts "stay"

end
end

if dealer_hand.value < 16
  dealer_hand.new_card(deck.deal)
else
  puts "Dealer stays"
end

puts "Your cards: #{player_hand.cards.join(" ")}"
puts "Dealer has: #{dealer_hand.cards.join(" ")}"

puts "The winner is:"
if dealer_hand.value < player_hand.value && player_hand.value <= 21
  puts "You! Good Game."
else
  puts "NOT YOU! You suck at BlackJack. Lulz."
end
