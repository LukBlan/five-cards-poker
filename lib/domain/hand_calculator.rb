class HandCalculator
  HAND_PRIORITY = {
    straight_flush: 1,
    four_of_a_king: 2,
    full_house: 3,
    flush: 4,
    straight: 5,
    three_of_a_kind: 6,
    two_pair: 7,
    pair: 8,
    high_card: 9
  }
  ACE = "A"
  KING = "K"
  FIVE = "5"

  def initialize(cards_order)
    @cards_order = cards_order
    @card_from_high_to_lover_value = cards_order.reverse
  end

  def process_hand(hand)
    sorted_hand = hand.sort_by { |card| @cards_order.index(card.value) }
    result = {high_card: sorted_hand[-1]}

    return result if check_flush_and_straight(sorted_hand, result)
    return result if check_cards_repetition(sorted_hand, result)

    result[:hand] = :high_card
    result
  end

  def high_card_value(result)
    high_card = result[:high_card]
    @card_from_high_to_lover_value.index(high_card)
  end

  def compute_hand_value(hand_result)
    hand = hand_result[:hand]
    HAND_PRIORITY[hand]
  end

  def check_cards_repetition(sorted_hand, result)
    repetition_hash = Hash.new { |hash, key| hash[key] = 0}
    sorted_hand.each { |card| repetition_hash[card.value] += 1 }
    repetition_value = repetition_hash.max_by { |key, value| value }[0]
    max_repetition_count = repetition_hash[repetition_value]

    return false if max_repetition_count == 1
    result[:high_card] = repetition_value

    if max_repetition_count == 4
      result[:hand] = :four_of_a_kind
    elsif max_repetition_count == 3 && repetition_hash.any? { |key, value| value == 2 }
      result[:hand] = :full_house
    elsif max_repetition_count == 3
      result[:hand] = :three_of_a_kind
    elsif repetition_hash.count { |key, value| value == 2} == 2
      result[:hand] = :two_pair
    else
      result[:hand] = :pair
    end

    true
  end

  def check_flush_and_straight(sorted_hand, result)
    flush = flush?(sorted_hand)
    straight = straight?(sorted_hand)

    if flush && straight
      result[:hand] = :straight_flush
    elsif flush
      result[:hand] = :flush
    elsif straight
      result[:hand] = :straight
    end

    flush || straight
  end

  def flush?(hand)
    first_card_type = hand[0].type
    hand.all? { |card| card.type.eql?(first_card_type) }
  end

  def straight?(hand)
    hand_values = hand.map { |card| card.value }
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
