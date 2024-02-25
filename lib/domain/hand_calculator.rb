class HandCalculator
  ACE = "A"
  KING = "K"
  FIVE = "5"

  def initialize(cards_order)
    @cards_order = cards_order
  end

  def compute_value(hand)
    flush = flush?(hand)
    straight = straight?(hand)

  end

  def flush?(hand)
    first_card_type = hand[0].type
    hand.all? { |card| card.type.eql?(first_card_type) }
  end

  def straight?(hand)
    hand_values = hand.map { |card| card.value }.sort_by { |value| @cards_order.index(value) }
    hand_without_repeat_values = hand_values.uniq

    return false if hand_without_repeat_values.length < 5
     if hand_values.include?(ACE)
       straight_with_ace?(hand_without_repeat_values)
     else
       straight_without_ace?(hand_without_repeat_values)
     end
  end

  def straight_without_ace?(hand_values)
    first_card_value = hand_values[0]
    card_index = @cards_order.index(first_card_value)

    hand_values.all? do |value|
      value_index = @cards_order.index(value)
      continuous_index = value_index == card_index
      card_index += 1
      continuous_index
    end
  end

  def straight_with_ace?(hand_values)
    last_card = hand_values[-1]
    hand_length = hand_values.length
    hand_values_without_ace = hand_values[1...hand_length]

    straight_without_ace?(hand_values_without_ace) && (last_card == KING || last_card == FIVE)
  end
end
