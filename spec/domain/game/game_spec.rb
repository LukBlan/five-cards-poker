require 'rspec'

RSpec.describe 'Game' do
  let(:game_factory) { GameFactory.new}
  let(:players_names) {["Player 1", "Player 2", "Player 3", "Player 4"]}
  subject { game_factory.create_game(players_names) }


end