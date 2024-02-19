class Game
  START_ROUND_BET = 1
  attr_reader :game_players, :pot_amount

  def initialize(players)
    @game_players = players
    @pot_amount = 0
  end

  def all_players_make_initial_bet
    @pot_amount += @game_players.length * START_ROUND_BET
    @game_players.each { |player| player.reduce_pot(START_ROUND_BET) }
  end
end
