class Player
  attr_reader :pot_amount, :current_bet, :name, :is_checked

  def initialize(name, pot_amount)
    @name = name
    @pot_amount = pot_amount
    @hand = []
    @current_bet = 0
    @is_checked = false
  end

  def play_turn(game)
    options = game.player_choice(self)
    player_options = options.map { |option| option.name }.join(" ")
    display_hand
    option = get_player_input("Choose your options: #{player_options}")
  end

  def display_hand
    hand_as_string = @hand.join(" ")
    puts(hand_as_string)
  end

  def raise_bet(game)
    amount = get_player_input("Hoy much do you want to raise bet")
    make_bet(game, amount)
  end

  def get_player_input(message)
    puts(message)
    gets.chomp.to_i
  end

  def uncheck
    @is_checked = false
  end

  def check
    @is_checked  = true
  end

  def receive_card(card)
    @hand << card
  end

  def all_in(game)
    make_bet(game, @pot_amount)
  end

  def all_in?(increase_amount)
    increase_amount == @pot_amount
  end

  def make_bet(game, amount)
    validate_reduced_amount(amount)
    game.new_bet(self, amount)
  end

  def reduce_pot(amount)
    @pot_amount -= amount
  end

  def process_bet(amount)
    reduce_pot(amount)
    @current_bet += amount
  end

  def reset_hand
    @hand = []
    @current_bet = 0
  end

  def max_possible_bet
    @current_bet + pot_amount
  end

  def validate_reduced_amount(amount)
    if amount > @pot_amount
      raise ArgumentError.new("Player lack of pot amount")
    end
  end
end
