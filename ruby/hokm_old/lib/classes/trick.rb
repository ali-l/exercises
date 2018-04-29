class Trick
  def initialize(cards, trump_suit=Card::SPADES)
    @trump_suit = trump_suit
    @cards = cards
  end

  def evaluate
    sorted_cards = @cards.sort do |a, b|
      if a.suit == b.suit
        value = b.value - a.value
        p "Comparing #{a} to #{b} based on suit, got #{value}"
        value
      elsif a.suit == @trump_suit
        p "Comparing #{a} to #{b}, #{a} has trump suit"
        -1
      elsif b.suit == @trump_suit
        p "Comparing #{a} to #{b}, #{b} has trump suit"
        1
      elsif a.suit == @cards.first.suit
        p "Comparing #{a} to #{b}, #{a} has trick suit"
        -1
      elsif b.suit == @cards.first.suit
        p "Comparing #{a} to #{b}, #{b} has trick suit"
        1
      else
        1
      end
    end

    winning_card = sorted_cards.first

    return @cards, sorted_cards, @cards.index(winning_card)
  end
end