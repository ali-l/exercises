class GameController < ApplicationController
  def index
    deck = Deck.new
    @hands = []
    4.times { @hands << Hand.new(deck.deal(13)).cards }
  end

  def evaluate_trick
    cards = JSON.load(params[:cards]).map { |card| Card.new(card['suit'], card['value']) }
    render json: Trick.new(cards).evaluate
  end
end
