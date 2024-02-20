require 'rspec'
require 'domain/game'

RSpec.describe 'Game' do
  let(:player1) { Player.new("Player1", 3) }
  let(:player2) { Player.new("Player2", 1) }
  let(:broke_player) { Player.new("BrokePlayer", 0)}
  subject { Game.new([player1, player2]) }

  describe "#all_players_make_initial_bet" do
    it "should increase de pot amount in the amount of players when a round start" do
      subject.all_players_make_initial_bet
      expect(subject.pot_amount).to be(2)
    end
  end

  describe "#end_round" do
    subject { Game.new([player1, broke_player, player2]) }

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
    subject { Game.new([player1, broke_player]) }
    let(:alternative_game) { Game.new([player1, player2])}

    it("should return false when there 2 or more players in the game") do
      expect(alternative_game.game_over).to be_falsy
    end

    it("should return on the end of a round and only one player have a pot amount > 0") do
      subject.end_round
      expect(subject.game_over).to be_truthy
    end
  end
end