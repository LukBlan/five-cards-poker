require 'rspec'
require 'domain/hand_calculator'
require 'domain/card/card'

RSpec.describe 'HandCalculator' do
  let(:cards_order) {
    ["A", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A"]
  }
  subject { HandCalculator.new(cards_order)}

  describe "#flush" do
    let(:flush_hand) {
      [Card.new("", :♣), Card.new("", :♣), Card.new("", :♣), Card.new("", :♣), Card.new("", :♣)]
    }
    let(:one_missing_card_from_flush) {
      [Card.new("", :♣), Card.new("", :♣), Card.new("", :♣), Card.new("", :♣), Card.new("", :♦)]
    }

    it("should return true if all card are of the same type") do
      expect(subject.flush?(flush_hand)).to be_truthy
    end

    it("should return false if one card is of different type") do
      expect(subject.flush?(one_missing_card_from_flush)).to be(false)
    end
  end
end
