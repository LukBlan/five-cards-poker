require 'rspec'
require 'domain/game/game_factory'

RSpec.describe 'Game' do
  let(:game_factory) { GameFactory.new}
  let(:players_names) {["Player 1", "Player 2", "Player 3", "Player 4"]}
  subject { game_factory.create_game(players_names) }

  describe "#all_players_make_initial_bet" do
    it "should increase de pot amount in 4 when the first round of a new game start" do
      subject.all_players_make_initial_bet
      expect(subject.pot_amount).to be(4)
    end
  end

end