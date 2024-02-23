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
    until @game.round_ends
      system("clear")
      player = @game.current_player_turn
      puts("#{player.name} turn")
      @game.play_turn
    end
  end
end
