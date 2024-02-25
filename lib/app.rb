require_relative 'domain/player'
require_relative 'domain/deck'
require_relative 'domain/game'
require_relative 'domain/card/poker_cards_factory'

require_relative 'ui/console_interface'

# Domain
players = [Player.new("Player 1", 10), Player.new("Player 2", 10)]
poker_card_factory = PokerCardsFactory.new
cards = poker_card_factory.create_cards
deck = Deck.new(cards)
game = Game.new(players, deck)

# Ui
console_interface = ConsoleInterface.new(game)
console_interface.init
