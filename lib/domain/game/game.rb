class Game
  START_ROUND_BET = 1
  attr_reader :game_players, :pot_amount

  def initialize(players)
    @game_players = players
    @pot_amount = 0
    @game_turn_controller = 0
    @round_turn_controller = 0
  end

  def all_players_make_initial_bet
    @game_players.each { |player| player.make_bet(self, START_ROUND_BET) }
  end

  def increase_pot(amount)
    @pot_amount += amount
  end

  def play_turn

  end
end
