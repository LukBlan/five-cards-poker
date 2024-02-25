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
    display_hand
    puts("Money: #{@pot_amount}")
    puts("Round bet accumulated: #{game.pot_amount}")
    player_option = get_player_option(options)
    executable_option = options.find { |option| option.name == player_option }
    executable_option.execute(game, self)
  end

  def call(game)
    bet_amount_difference = game.current_max_bet - @current_bet
    make_bet(game, bet_amount_difference)
  end

  def get_player_option(options)
    player_options = options.map { |option| option.name }

    loop do
      option = get_player_input("Choose your options: #{player_options}")

      if player_options.include?(option)
        return option
      end

      puts("Invalid option try again")
    end
  end

  def display_hand
    @hand.each { |card| print("#{card.to_s} ") }
    puts
  end

  def raise_bet(game)
    amount = get_player_input("Hoy much do you want to raise bet").to_i
    make_bet(game, amount)
  end

  def get_player_input(message)
    puts(message)
    gets.chomp
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
