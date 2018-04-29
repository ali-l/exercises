class Game
  def initialize
    @deck = Deck.new
    @hands = deal_hands
    # @trump_suit = Card::SPADES
  end

  def play
    13.times { p play_trick;puts }
  end


  private

  def play_trick
    trick_cards = []
    @hands.each do |hand|
      trick_cards << hand.cards.pop
    end
    Trick.new(trick_cards).evaluate
  end

  def deal_hands
    hands = []
    4.times { hands << Hand.new(@deck.deal(13)) }
    hands
  end

end