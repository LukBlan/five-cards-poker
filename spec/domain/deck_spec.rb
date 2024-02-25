require 'rspec'
require "domain/deck"
require 'domain/hand_calculator'

RSpec.describe 'Deck' do
  let(:hand_calculator) { HandCalculator.new([])}
  subject { Deck.new(["card1", "card2", "card3", "card4", "card5"], hand_calculator) }
  let(:player) {double("player", :receive_card => "test")}

  describe "#give_cards_to" do
    it("should discard given cards from de deck") do
      subject.give_cards_to(player, 2)
      expect(subject.current_cards.length).to be(3)
    end
  end

  describe "#reset" do
    it("should merge discard cards in the deck") do
      subject.reset
      expect(subject.current_cards.length).to be(5)
    end
  end
end
