class Player
  Re  attr_reader :pot_amount, :current_bet

  def initialize(name, pot_amount)
    @name = name
    @pot_amount = pot_amount
    @hand = []
    @current_bet = 0
  end

  def receive_card(card)
    @hand << card
  end

  def all_in?(increase_amount)
    increase_amount == @pot_amount
  end

  def reduce_pot(amount)
    @pot_amount -= amount
  end

  def make_bet(game, amount)
    validate_reduced_amount(amount)
    game.new_bet(self, amount)
  end

  def process_bet(amount)
    reduce_pot(amount)
    @current_bet += amount
  end

  def reset_hand
    @hand = []
    @current_bet = 0
  end

  def validate_reduced_amount(amount)
    if amount > @pot_amount
      raise ArgumentError.new("Player lack of pot amount")
    end
  end
end
