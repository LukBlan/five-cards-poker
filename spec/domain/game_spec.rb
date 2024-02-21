require 'rspec'
require 'domain/game'
require 'domain/deck'

RSpec.describe 'Game' do
  let(:player1) { Player.new("Player1", 3) }
  let(:player2) { Player.new("Player2", 2) }
  let(:broke_player) { Player.new("BrokePlayer", 0)}
  let(:deck) { Deck.new([]) }
  subject { Game.new([player1, player2], deck) }

  describe "#all_players_make_initial_bet" do
    it "should increase de pot amount in the amount of players when a round start" do
      subject.all_players_make_initial_bet
      expect(subject.pot_amount).to be(2)
    end
  end

  describe "#end_round" do
    subject { Game.new([player1, broke_player, player2], deck) }

    it("should remove players with pot amount equal to 0") do
      expect(subject.players_amount).to be(3)
      subject.end_round
      expect(subject.players_amount).to be(2)
    end
  end

  describe "#start round" do
    it("should set players to play the round") do
      subject.start_round
      expect(subject.current_player_turn).to be(player1)
    end
  end

  describe "#game_over" do
    let(:alternative_game) { Game.new([player1, broke_player], deck)}

    it("should return false when there 2 or more players in the game") do
      expect(subject.game_over).to be_falsy
    end

    it("should return on the end of a round and only one player have a pot amount > 0") do
      alternative_game.end_round
      expect(alternative_game.game_over).to be_truthy
    end
  end

  describe "#new_bet" do
    it("should raise an exception if the player try to bet less than the actual max bet an is not all in") do
      subject.new_bet(player1, 3)
      expect { subject.new_bet(player2, 1) }.to raise_exception("Player bet amount is less than max")
    end
  end

  describe "#reset_players_hand" do
    let(:mock_player1) { double("player1", :reset_hand => "", :pot_amount => 3) }
    subject { Game.new([mock_player1], deck) }

    it("should send a message to all players to reset hands") do
      expect(mock_player1).to receive(:reset_hand)
      subject.end_round
    end
  end
end