class Player
  attr_reader :pot_amount, :current_bet, :name, :is_checked, :hand, :change_card_available

  def initialize(name, pot_amount)
    @name = name
    @pot_amount = pot_amount
    @hand = []
    @current_bet = 0
    @is_checked = false
    @change_card_available = true
  end

  def play_turn(game)
    display_current_round_state(game)
    options = game.player_choice(self)
    player_option = get_player_option(options)
    executable_option = options.find { |option| option.name == player_option }
    executable_option.execute(game, self)
  end

  def change_cards(game)
    list_cards_index = get_player_card_list
    list_of_cards = list_cards_index.map { |index| @hand[index.to_i - 1] }
    @hand = @hand.filter { |card| !list_of_cards.include?(card) }
    @change_card_available = false
    game.give_cards_to_player(self, list_of_cards.length)
  end

  def get_player_card_list
    loop do
      user_input = get_player_input("List card index separated by coma (e.g 1,3,4)")

      begin
        coma_separated_input = user_input.split(",")
        check_user_input(coma_separated_input)
        return coma_separated_input.map(&:to_i)
      rescue
        puts("Invalid Input, try again")
      end
    end
  end

  def check_user_input(coma_separated_input)
    if coma_separated_input.any? { |input| input.to_i < 1 || input.to_i > @hand.length }
      raise ArgumentError.new("Input is not between hand range (1 to 5)")
    end
  end

  def display_current_round_state(game)
    system("clear")
    puts("         Round #{game.round_number}")
    puts("         #{@name} turn")
    display_hand
    puts("Player Money: #{@pot_amount}")
    puts("Round Money accumulated: #{game.pot_amount}")
    puts("Current max bet: #{game.current_max_bet}")
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

  def increase_pot(amount)
    @pot_amount += amount
  end

  def process_bet(amount)
    reduce_pot(amount)
    @current_bet += amount
  end

  def reset
    @hand = []
    @current_bet = 0
    @change_card_available = true
    uncheck
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
