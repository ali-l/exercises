class Hand
  attr_accessor :cards

  def initialize(cards)
    @cards = cards
    sort!
  end

  def sort!
    cards.sort! do |a, b|
      (a.suit_order == b.suit_order) ? b.value - a.value : a.suit_order - b.suit_order
    end
  end

  def to_s
    cards
  end

  def inspect
    to_s
  end
end
