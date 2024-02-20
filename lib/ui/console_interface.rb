class ConsoleInterface
  def initialize(game)
    @game = game
  end

  def init
    game_loop
  end

  def game_loop
    until @game.game_over
      @game.start_round
      @game.all_players_make_initial_bet
      # play round
      @game.end_round
  end
end
