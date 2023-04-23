require 'game_maker'
require 'game'
require 'board'
require 'ship'

RSpec.describe "GameMaker integration" do
  it "makes a game with a player board" do
    game_maker = GameMaker.new(Game, Board, Ship)
    game = game_maker.make_game
    result = game.player_board.is_a?(Board)
    expect(result).to eq true
  end

  it "makes a game with an opponent board" do
    game_maker = GameMaker.new(Game, Board, Ship)
    game = game_maker.make_game
    result = game.opponent_board.is_a?(Board)
    expect(result).to eq true
  end
  
  it "gives Ship objects to the board" do
    game_maker = GameMaker.new(Game, Board, Ship)
    game = game_maker.make_game
    result = game.player_board.unplaced_ships.all? { |ship| ship.is_a?(Ship)}
    expect(result).to eq true
  end
  
  it "gives five ships to the board" do
    game_maker = GameMaker.new(Game, Board, Ship)
    game = game_maker.make_game
    result = game.player_board.unplaced_ships.length
    expect(result).to eq 5
  end
end
