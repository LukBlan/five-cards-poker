class HandCalculator
  def initialize(cards_order)
    @cards_order = cards_order
  end

  def compute_value(hand)
    flush = flush?(hand)
  end

  def flush?(hand)
    first_card_type = hand[0].type
    hand.all? { |card| card.type.eql?(first_card_type)}
  end
end
