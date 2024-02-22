class Fold
  def execute(game, player)
    game.remove_player_from_round(player)
  end

  def name
    "fold"
  end
end
