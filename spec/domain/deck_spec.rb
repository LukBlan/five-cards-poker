require 'rspec'
require "domain/deck"

RSpec.describe 'Deck' do
  subject { Deck.new(["card1", "card2", "card3", "card4", "card5"]) }
  let(:player) {double("player", :receive_card => "test")}

  describe "#give_cards_to" do
    it("should discard given cards from de deck") do
      expect(subject.current_cards.length).to be(5)
      subject.give_cards_to(player, 2)
      expect(subject.current_cards.length).to be(3)
    end
  end
end
