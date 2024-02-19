class Game
  START_ROUND_BET = 1
  attr_reader :game_players, :pot_amount

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

  def end_round
    # remove losers
    # increase game turn controller based on remained players
  end

  def play_turn
    player = @round_player
  end
end
