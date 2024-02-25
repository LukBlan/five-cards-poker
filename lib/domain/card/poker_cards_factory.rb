require_relative 'card'

class PokerCardsFactory
  def create_cards
    cards = []
    cards_values = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A"]
    cards_types = [:♣, :♦, :♥, :♠]

    cards_values.each do |value|
      cards_types.each do |type|
        cards << Card.new(value, type)
      end
    end

    cards
  end
end
