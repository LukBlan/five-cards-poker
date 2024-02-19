# frozen_string_literal: true

class Player
  def initialize(name)
    @name = name
    @pot_amount = 10
  end

  def reduce_pot(amount)
    @pot_amount -= amount
  end
end
