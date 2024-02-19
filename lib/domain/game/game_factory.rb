require_relative 'game'
require_relative '../player'

class GameFactory
  def create_game(players_names)
    players = players_names.map { |player_name| Player.new(player_name) }
    Game.new(players)
  end
end
