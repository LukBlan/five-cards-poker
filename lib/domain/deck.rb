class Deck
  attr_reader :current_cards

  def initialize(cards)
    @current_cards = cards
    @discard_cards = []
  end

  def give_cards_to(player, amount)
    amount.times do
      give_card(player)
    end
  end

  def reset
    @current_cards += @discard_cards
  end

  def give_card(player)
    random_card_position = rand(@current_cards.length)
    card = @current_cards.delete_at(random_card_position)

    @discard_cards << card
    player.receive_card(card)
  end
end
