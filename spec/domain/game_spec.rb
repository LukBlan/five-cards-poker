require 'rspec'
require 'domain/game'
require 'domain/deck'
require "domain/player"

RSpec.describe 'Game' do
  let(:player1) { Player.new("Player1", 3) }
  let(:player2) { Player.new("Player2", 2) }
  let(:broke_player) { Player.new("BrokePlayer", 0)}
  let(:deck) { Deck.new([]) }
  subject { Game.new([player1, player2], deck) }

  describe "#remove_losers" do
    subject { Game.new([player1, broke_player, player2], deck) }

    it("should remove players with pot amount equal to 0") do
      subject.remove_losers
      expect(subject.players_amount).to be(2)
    end
  end

  describe "#start round" do
    before(:each) do
      subject.start_round
    end

    it "should increase de pot amount in the amount of players when a round start" do
      expect(subject.pot_amount).to be(2)
    end

    it("should set players to play the round") do
      expect(subject.current_player_turn).to be(player1)
    end
  end

  describe "#game_over" do
    let(:alternative_game) { Game.new([player1, broke_player], deck)}

    it("should return false when there 2 or more players in the game") do
      expect(subject.game_over).to be_falsy
    end

    it("should return true if only one player remain in game") do
      alternative_game.remove_losers
      expect(alternative_game.game_over).to be_truthy
    end
  end

  describe "#new_bet" do
    let(:player3) { Player.new("Player3", 10)}

    it("should raise an exception if the player try to bet less than the actual max bet an is not all in") do
      subject.new_bet(player3, 10)
      expect { subject.new_bet(player1, 1) }.to raise_exception("Player bet amount is less than max")
    end
  end

  describe "#remove_player_from_round" do
    subject { Game.new([player1], deck) }

    it "should remove from the current round" do
      subject.start_round
      subject.remove_player_from_round(player1)
      expect(subject.remaining_players_in_round).to be(0)
    end
  end

  describe "#round_ends" do
    before(:each) do
      subject.start_round
    end

    it("should true when all players are checked") do
      player1.check
      player2.check
      expect(subject.round_ends).to be_truthy
    end

    it("should return false when one players is not checked") do
      player1.check
      expect(subject.round_ends).to be(false)
    end
  end
end