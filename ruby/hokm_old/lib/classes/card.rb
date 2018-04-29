class Card
  SPADES = 'Spades'
  HEARTS = 'Hearts'
  DIAMONDS = 'Diamonds'
  CLUBS = 'Clubs'

  SUITS = [SPADES, HEARTS, DIAMONDS, CLUBS]

  FACE_CARDS = Hash.new{|hash, key| key}.merge({11 => 'Jack',
                                                12 => 'Queen',
                                                13 => 'King',
                                                14 => 'Ace'})

  attr_reader :suit, :value

  def initialize(suit, value)
    @suit = suit
    @value = value
  end

  def inspect
    to_s
  end

  def suit_order
    SUITS.find_index(suit)
  end

  def to_s
    "#{FACE_CARDS[value]} of #{suit}"
  end

end