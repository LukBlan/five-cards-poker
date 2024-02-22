class Raise
  def execute(game, player)
    player.raise_bet(game)
  end

  def name
    "raise"
  end
end
