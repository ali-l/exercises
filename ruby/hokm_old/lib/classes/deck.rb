class Deck
  def initialize
    @cards = []
    generate_cards!
  end

  def deal(num = 1)
    @cards.slice!(0, num)
  end

  def inspect
    to_s
  end

  def to_s
    "Deck of #{@cards.length} cards"
  end

  private

  def generate_cards!
    Card::SUITS.each do |suit|
      (2..14).each do |value|
        @cards << Card.new(suit, value)
      end
    end
    @cards.shuffle!
  end
end