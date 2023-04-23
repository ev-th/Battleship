require 'board_formatter'

RSpec.describe BoardFormatter do
  describe "#format_as_player" do
    it "returns a string representation of the ship positions on the grid" do
      fake_ship_1 = double :fake_ship_1
      fake_ship_2 = double :fake_ship_2
      fake_ship_3 = double :fake_ship_3
      grid = [
        [{ship: nil, hit: false}, {ship: fake_ship_1, hit: false}, {ship: fake_ship_1, hit: false}, {ship: fake_ship_1, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
        [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
        [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: fake_ship_2, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
        [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: fake_ship_2, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
        [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
        [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
        [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
        [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: fake_ship_3, hit: false}, {ship: fake_ship_3, hit: false}, {ship: fake_ship_3, hit: false}, {ship: fake_ship_3, hit: false}, {ship: fake_ship_3, hit: false}, {ship: nil, hit: false}],
        [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
        [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}]
      ]
      fake_board = double :fake_board, grid: grid
      
      expected_result = "  | A | B | C | D | E | F | G | H | I | J |\n" +
      "--|---+---+---+---+---+---+---+---+---+---|\n" +
      "1 |   | S | S | S |   |   |   |   |   |   |\n" +
      "--|---+---+---+---+---+---+---+---+---+---|\n" +
      "2 |   |   |   |   |   |   |   |   |   |   |\n" +
      "--|---+---+---+---+---+---+---+---+---+---|\n" +
      "3 |   |   |   |   |   | S |   |   |   |   |\n" +
      "--|---+---+---+---+---+---+---+---+---+---|\n" +
      "4 |   |   |   |   |   | S |   |   |   |   |\n" +
      "--|---+---+---+---+---+---+---+---+---+---|\n" +
      "5 |   |   |   |   |   |   |   |   |   |   |\n" +
      "--|---+---+---+---+---+---+---+---+---+---|\n" +
      "6 |   |   |   |   |   |   |   |   |   |   |\n" +
      "--|---+---+---+---+---+---+---+---+---+---|\n" +
      "7 |   |   |   |   |   |   |   |   |   |   |\n" +
      "--|---+---+---+---+---+---+---+---+---+---|\n" +
      "8 |   |   |   |   | S | S | S | S | S |   |\n" +
      "--|---+---+---+---+---+---+---+---+---+---|\n" +
      "9 |   |   |   |   |   |   |   |   |   |   |\n" +
      "--|---+---+---+---+---+---+---+---+---+---|\n" +
      "10|   |   |   |   |   |   |   |   |   |   |\n" +
      "------------------------------------------+"
      formatter = BoardFormatter.new(fake_board)
      result = formatter.format_as_player
      expect(result).to eq expected_result
    end
    
    it "returns a string representation of the hit positions on the grid" do
      fake_ship_1 = double :fake_ship_1
      fake_ship_2 = double :fake_ship_2
      fake_ship_3 = double :fake_ship_3

      grid = [
        [{ship: nil, hit: true}, {ship: fake_ship_1, hit: false}, {ship: fake_ship_1, hit: false}, {ship: fake_ship_1, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
        [{ship: nil, hit: false}, {ship: nil, hit: true}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
        [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: true}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: fake_ship_2, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: true}, {ship: nil, hit: true}, {ship: nil, hit: true}],
        [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: fake_ship_2, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
        [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
        [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
        [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
        [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: fake_ship_3, hit: true}, {ship: fake_ship_3, hit: false}, {ship: fake_ship_3, hit: false}, {ship: fake_ship_3, hit: false}, {ship: fake_ship_3, hit: false}, {ship: nil, hit: false}],
        [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: true}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
        [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: true}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}]
      ]
      fake_board = double :fake_board, grid: grid
      
      expected_result = "  | A | B | C | D | E | F | G | H | I | J |\n" +
      "--|---+---+---+---+---+---+---+---+---+---|\n" +
      "1 | X |   |   |   |   |   |   |   |   |   |\n" +
      "--|---+---+---+---+---+---+---+---+---+---|\n" +
      "2 |   | X |   |   |   |   |   |   |   |   |\n" +
      "--|---+---+---+---+---+---+---+---+---+---|\n" +
      "3 |   |   | X |   |   |   |   | X | X | X |\n" +
      "--|---+---+---+---+---+---+---+---+---+---|\n" +
      "4 |   |   |   |   |   |   |   |   |   |   |\n" +
      "--|---+---+---+---+---+---+---+---+---+---|\n" +
      "5 |   |   |   |   |   |   |   |   |   |   |\n" +
      "--|---+---+---+---+---+---+---+---+---+---|\n" +
      "6 |   |   |   |   |   |   |   |   |   |   |\n" +
      "--|---+---+---+---+---+---+---+---+---+---|\n" +
      "7 |   |   |   |   |   |   |   |   |   |   |\n" +
      "--|---+---+---+---+---+---+---+---+---+---|\n" +
      "8 |   |   |   |   | X |   |   |   |   |   |\n" +
      "--|---+---+---+---+---+---+---+---+---+---|\n" +
      "9 |   |   |   |   | X |   |   |   |   |   |\n" +
      "--|---+---+---+---+---+---+---+---+---+---|\n" +
      "10|   |   |   | X |   |   |   |   |   |   |\n" +
      "------------------------------------------+"

      formatter = BoardFormatter.new(fake_board)
      result = formatter.format_as_opponent
      expect(result).to eq expected_result
    end
  end
end