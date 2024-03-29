require 'rspec'
require 'domain/player'
require 'domain/hand_calculator'

RSpec.describe 'Player' do
  let(:hand_calculator) { HandCalculator.new([])}
  subject { Player.new("Player 1", 10) }
  let(:game) { Game.new([subject], Deck.new([], hand_calculator)) }

  describe "#make_bet" do
    it("should reduce players pot amount in 3") do
      subject.make_bet(game, 3)
      expect(subject.pot_amount).to be(7)
    end

    it("should raise and exception if the amount is bigger than the player pot amount") do
      expect { subject.make_bet(game, 11) }.to raise_exception("Player lack of pot amount")
    end
  end

  describe "#all_in?" do
    it "should return true if the amount is equal to the amount of player pot" do
      expect(subject.all_in?(10)).to be_truthy
    end

    it "should return false if the amount is less than the player pot" do
      expect(subject.all_in?(5)).to be(false)
    end
  end

  describe "#all_in" do
    it "should bet all of the player money" do
      subject.all_in(game)
      expect(subject.pot_amount).to be(0)
    end
  end
end
