require 'rspec'
require 'domain/hand_calculator'
require 'domain/card/card'

RSpec.describe 'HandCalculator' do
  let(:cards_order) { ["A", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A"] }
  subject { HandCalculator.new(cards_order)}
  let(:straight_flush_hand) {
    [Card.new("2", :♣), Card.new("3", :♣), Card.new("4", :♣), Card.new("5", :♣), Card.new("6", :♣)]
  }

  let(:missing_straight) {
    [Card.new("2", :♣), Card.new("4", :♣), Card.new("5", :♣), Card.new("6", :♣), Card.new("7", :♣)]
  }

  let(:missing_straight_with_ace) {
    [Card.new("A", :♣), Card.new("4", :♣), Card.new("5", :♣), Card.new("6", :♣), Card.new("7", :♣)]
  }

  let(:ace_par) {
    [Card.new("A", :♣), Card.new("A", :♣), Card.new("3", :♣), Card.new("4", :♣), Card.new("5", :♣)]
  }

  let(:straight_with_bottom_ace) {
    [Card.new("A", :♣), Card.new("2", :♣), Card.new("3", :♣), Card.new("4", :♣), Card.new("5", :♣)]
  }

  let(:straight_with_top_ace) {
    [Card.new("A", :♣), Card.new("10", :♣), Card.new("J", :♣), Card.new("Q", :♣), Card.new("K", :♣)]
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

  describe "#check_cards_repetition" do
    let(:four_repetition) {
      [Card.new("A", :♣), Card.new("A", :♣), Card.new("A", :♣), Card.new("A", :♣), Card.new("K", :♣)]
    }

    let(:full_house) {
      [Card.new("A", :♣), Card.new("A", :♣), Card.new("A", :♣), Card.new("K", :♣), Card.new("K", :♣)]
    }

    let(:three_of_a_kind) {
      [Card.new("A", :♣), Card.new("A", :♣), Card.new("A", :♣), Card.new("K", :♣), Card.new("Q", :♣)]
    }

    let(:two_pairs) {
      [Card.new("A", :♣), Card.new("A", :♣), Card.new("J", :♣), Card.new("K", :♣), Card.new("K", :♣)]
    }

    let(:pair) {
      [Card.new("A", :♣), Card.new("A", :♣), Card.new("J", :♣), Card.new("K", :♣), Card.new("10", :♣)]
    }

    let(:result) {
      {}
    }

    it("should return true when there 4 repetitions of the same type") do
      expect(subject.check_cards_repetition(four_repetition, result)).to be_truthy
      expect(result[:hand]).to be(:four_of_a_kind)
    end

    it("should return true when the are 3 repetition of one card and 2 of other") do
      expect(subject.check_cards_repetition(full_house, result)).to be(true)
      expect(result[:hand]).to be(:full_house)
    end

    it("should return true when the are only 3 repetition of a card") do
      expect(subject.check_cards_repetition(three_of_a_kind, result)).to be(true)
      expect(result[:hand]).to be(:three_of_a_kind)
    end

    it("should return true when there 2times 2 repetitions of 2 cards") do
      expect(subject.check_cards_repetition(two_pairs, result)).to be_truthy
      expect(result[:hand]).to be(:two_pair)
    end

    it("should return true when there only 1 time 2 repetition of a card") do
      expect(subject.check_cards_repetition(pair, result)).to be_truthy
      expect(result[:hand]).to be(:pair)
    end
  end
end
