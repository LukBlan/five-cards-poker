require_relative 'domain/player'
require_relative 'domain/deck'
require_relative 'domain/game'

require_relative 'ui/console_interface'

# Domain
players = [Player.new("Player 1", 10), Player.new("Player 2", 10)]
cards = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
deck = Deck.new(cards)
game = Game.new(players, deck)

# Ui
console_interface = ConsoleInterface.new(game)
console_interface.init
