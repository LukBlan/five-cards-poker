# frozen_string_literal: true

class Player
  attr_reader :pot_amount

  def initialize(name, pot_amount)
    @name = name
    @pot_amount = pot_amount
  end

  def reduce_pot(amount)
    @pot_amount -= amount
  end

  def make_bet(game, amount)
    validate_reduced_amount(amount)
    reduce_pot(amount)
    game.increase_pot(amount)
  end

  def validate_reduced_amount(amount)
    if amount > @pot_amount
      raise ArgumentError.new("Player lack of pot amount")
    end
  end
end
