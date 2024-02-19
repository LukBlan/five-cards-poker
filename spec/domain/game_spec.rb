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
    subject { Game.new([player1, broke_player]) }

    it("should remove players with pot amount equal to 0") do
      expect(subject.players_amount).to be(2)
      subject.end_round
      expect(subject.players_amount).to be(1)
    end
  end
end