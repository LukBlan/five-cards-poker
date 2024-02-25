# frozen_string_literal: true

class Call
  def execute(game, player)
    player.call(game)
  end

  def name
    "call"
  end
end
