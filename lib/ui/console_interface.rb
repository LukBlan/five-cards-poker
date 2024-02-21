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
      round_loop
      @game.end_round
    end
  end

  def round_loop
    until round_over
      # get current player
      # play turn
    end
  end
end
