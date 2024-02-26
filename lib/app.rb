require_relative 'domain/player'
require_relative 'domain/deck'
require_relative 'domain/game'
require_relative 'domain/card/poker_cards_factory'
require_relative 'domain/hand_calculator'
require_relative 'ui/console_interface'

# Domain
players = [Player.new("Player 1", 10), Player.new("Player 2", 10)]
poker_card_factory = PokerCardsFactory.new
cards = poker_card_factory.create_cards
hand_calculator = HandCalculator.new(["A", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A"])
deck = Deck.new(cards, hand_calculator)
game = Game.new(players, deck)

# Ui
console_interface = ConsoleInterface.new(game)
console_interface.init
