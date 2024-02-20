class Game
  START_ROUND_BET = 1
  attr_reader :pot_amount

  def initialize(players)
    @game_players = players
    @round_players = nil
    @pot_amount = 0
    @game_turn_controller = 0
    @round_turn_controller = nil
  end

  def all_players_make_initial_bet
    @game_players.each { |player| player.make_bet(self, START_ROUND_BET) }
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
  end

  def current_player_turn
    @round_players[@round_turn_controller]
  end

  def end_round
    @game_players = @game_players.filter { |player| player.pot_amount != 0 }
    @game_turn_controller = @game_turn_controller + 1 % @game_players.length
  end

  def players_amount
    @game_players.length
  end
end