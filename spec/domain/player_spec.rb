require 'rspec'
require 'domain/player'

RSpec.describe 'Player' do
  let(:game) { double("game", increase_pot: "") }
  subject { Player.new("Player 1") }

  describe "make_bet" do
    it("should reduce players pot amount in 3") do
      subject.make_bet(game, 3)
      expect(subject.pot_amount).to be(7)
    end

    it("should raise and exception if the amount is bigger than the player pot amount") do
      expect {subject.make_bet(game, 11)}.to raise_exception("Player lack of pot amount")
    end

    it("should send a message to the game to increase the bet amount") do
      subject.make_bet(game, 3)
      expect(game).to have_received(:increase_pot)
    end
  end
end
