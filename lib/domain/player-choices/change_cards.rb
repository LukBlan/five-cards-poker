class ChangeCards
  def execute(game, player)
    player.change_cards(game)
  end

  def name
    "change_cards"
  end
end
