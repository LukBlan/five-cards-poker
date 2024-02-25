require 'rspec'
require 'domain/hand_calculator'
require 'domain/card/card'

RSpec.describe 'HandCalculator' do
  let(:cards_order) { ["A", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A"] }
  subject { HandCalculator.new(cards_order)}
  let(:straight_flush_hand) {
    [Card.new("4", :♣), Card.new("3", :♣), Card.new("2", :♣), Card.new("6", :♣), Card.new("5", :♣)]
  }

  let(:missing_straight) {
    [Card.new("4", :♣), Card.new("7", :♣), Card.new("2", :♣), Card.new("6", :♣), Card.new("5", :♣)]
  }

  let(:missing_straight_with_ace) {
    [Card.new("4", :♣), Card.new("7", :♣), Card.new("A", :♣), Card.new("6", :♣), Card.new("5", :♣)]
  }

  let(:ace_par) {
    [Card.new("A", :♣), Card.new("A", :♣), Card.new("3", :♣), Card.new("4", :♣), Card.new("5", :♣)]
  }

  let(:straight_with_bottom_ace) {
    [Card.new("4", :♣), Card.new("3", :♣), Card.new("2", :♣), Card.new("A", :♣), Card.new("5", :♣)]
  }

  let(:straight_with_top_ace) {
    [Card.new("J", :♣), Card.new("A", :♣), Card.new("K", :♣), Card.new("10", :♣), Card.new("Q", :♣)]
  }

  describe "#flush" do
    let(:one_missing_card_from_flush) {
      [Card.new("", :♣), Card.new("", :♣), Card.new("", :♣), Card.new("", :♣), Card.new("", :♦)]
    }

    it("should return true if all card are of the same type") do
      expect(subject.flush?(straight_flush_hand)).to be_truthy
    end

    it("should return false if one card is of different type") do
      expect(subject.flush?(one_missing_card_from_flush)).to be(false)
    end
  end

  describe "#straight?" do
    it("should return true when hand is a straight") do
      expect(subject.straight?(straight_flush_hand)).to be_truthy
    end

    it("should return false then it have repeated values") do
      expect(subject.straight?(ace_par)).to be(false)
    end

    it("should return false if it have jumps in values") do
      expect(subject.straight?(missing_straight)).to be(false)
    end

    it("should return true when it is a straight with ace as bottom card") do
      expect(subject.straight?(straight_with_bottom_ace)).to be_truthy
    end

    it("should return true when it is a straight with ace as top card") do
      expect(subject.straight?(straight_with_top_ace)).to be_truthy
    end

    it("should return false if it not a straight with ace") do
      expect(subject.straight?(missing_straight_with_ace)).to be(false)
    end
  end
end
