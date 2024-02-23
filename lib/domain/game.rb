require_relative 'player-choices/fold'
require_relative 'player-choices/raise'
require_relative 'player-choices/all_in'
require_relative 'player-choices/check'

class Game
  START_ROUND_BET = 1
  START_ROUND_CARDS = 5
  attr_reader :pot_amount

  def initialize(players, deck)
    @game_players = players
    @round_players = []
    @pot_amount = 0
    @game_turn_controller = 0
    @round_turn_controller = 0
    @deck = deck
    @current_max_bet = 0
  end

  def all_players_make_initial_bet
    @game_players.each { |player| player.make_bet(self, START_ROUND_BET) }
  end

  def new_bet(player, increase_amount)
    new_bet = player.current_bet + increase_amount

    if !player.all_in?(increase_amount) && @current_max_bet > new_bet
      raise ArgumentError.new("Player bet amount is less than max")
    elsif @current_max_bet < new_bet
      @round_players.each { |player| player.uncheck }
    end

    @current_max_bet = new_bet
    player.process_bet(increase_amount)
    increase_pot(increase_amount)
  end

  def round_ends
    @round_players.all? { |player| player.is_checked }
  end

  def increase_pot(amount)
    @pot_amount += amount
  end

  def game_over
    @game_players.length == 1
  end

  def start_round
    @round_players = @game_players
    @round_turn_controller = @game_turn_controller
    give_cards_to_players
    all_players_make_initial_bet
  end

  def current_player_turn
    @round_players[@round_turn_controller]
  end

  def end_round
    @game_players = @game_players.filter { |player| player.pot_amount != 0 }
    @game_turn_controller = @game_turn_controller + 1 % @game_players.length
    @deck.reset
    reset_players_hands
  end

  def play_turn
    player = current_player_turn
    player.play_turn(self)
  end

  def give_cards_to_players
    @game_players.each do |player|
      @deck.give_cards_to(player, START_ROUND_CARDS)
    end
  end

  def reset_players_hands
    @game_players.each { |player| player.reset_hand }
  end

  def players_amount
    @game_players.length
  end

  def player_choice(player)
    player_choices = []
    player_choices << Fold.new

    if @current_max_bet > player.max_possible_bet
      player_choices << AllIn.new
    else
      player_choices << Raise.new
    end
  end

  def remove_player_from_round(player)
    player_name = player.name
    player_index = @round_players.find_index { |player_in_round| player_in_round.name.eql?(player_name) }
    @round_players.delete_at(player_index)
  end

  def remaining_players_in_round
    @round_players.length
  end
end
