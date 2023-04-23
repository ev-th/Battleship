require 'game'
require 'board'
require 'ship'

describe "Game integration" do
  context "initially" do
    it "has two boards" do
      board_1 = Board.new([])
      board_2 = Board.new([])
      game = Game.new(board_1, board_2)
      expect(game.current_player_board).to eq board_1
      expect(game.current_opponent_board).to eq board_2
    end
  end

  describe "#place_ship" do
    context "when a ship is placed on valid coordinates of the player board" do
      it "updates the board" do
        ship_1 = Ship.new(3)
        board_1 = Board.new([ship_1])
        board_2 = Board.new([])
        game = Game.new(board_1, board_2)
        game.place_ship(3, 'B3', 'horizontal')
        
        expected_grid = [
          [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
          [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
          [{ship: nil, hit: false}, {ship: ship_1, hit: false}, {ship: ship_1, hit: false}, {ship: ship_1, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
          [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
          [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
          [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
          [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
          [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
          [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
          [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}]
        ]
        expect(board_1.grid).to eq expected_grid
      end
      
      it "moves the ship to placed_ships" do
        ship_1 = Ship.new(3)
        board_1 = Board.new([ship_1])
        board_2 = Board.new([])
        game = Game.new(board_1, board_2)
        game.place_ship(3, 'B3', 'horizontal')
        expect(board_1.placed_ships).to eq [ship_1]
      end
      
      it "removes the ship from unplaced_ships" do
        ship_1 = Ship.new(3)
        board_1 = Board.new([ship_1])
        board_2 = Board.new([])
        game = Game.new(board_1, board_2)
        game.place_ship(3, 'B3', 'horizontal')
        expect(board_1.unplaced_ships).to eq []
      end
    end
    
    context "when a ship is placed out of bounds" do
      it "fails" do
        ship_1 = Ship.new(3)
        board_1 = Board.new([ship_1])
        board_2 = Board.new([])
        game = Game.new(board_1, board_2)
        expect {
          game.place_ship(3, 'I6', 'horizontal')
        }.to raise_error "Some of the ship cannot fit on the board in this position."
      end
    end
    
    context "when a ship is placed on top of another ship on the player board" do
      it "fails" do
        ship_1 = Ship.new(3)
        ship_2 = Ship.new(4)
        board_1 = Board.new([ship_1, ship_2])
        board_2 = Board.new([])
        game = Game.new(board_1, board_2)
        game.place_ship(4, "A1", "vertical")
        expect {
          game.place_ship(3, 'A3', 'horizontal')
        }.to raise_error "There is already a ship placed there."
      end
    end
    
    context "when the ship is not available to place" do
      it "fails" do
        ship_1 = Ship.new(3)
        board_1 = Board.new([ship_1])
        board_2 = Board.new([])
        game = Game.new(board_1, board_2)
        expect {
          game.place_ship(4, 'A3', 'horizontal')
        }.to raise_error "There are no ships of this length available to place."
      end
    end
  end

  describe "#shoot" do
    context "when passed a coordinate that has not been hit on the opponent's board" do
      xit "records the hit on the opponent's board" do
        
      end
      
      context "when a ship is found at that coordinate" do
        xit "damages the ship" do
        end
        
        context "if the ship is partially damaged" do
          xit "returns a value to indicate a hit" do
          end
        end
        
        context "if the ship is sunk" do
          xit "returns a value to indicate a ship has been sunk" do
          end
        end
      end

      context "when a ship is not found at that coordinate" do
        xit "makes no change to the opponent's ships" do
        end

        xit "returns a value to indicate a miss" do
        end
      end
    end

    context "when passed a coordinate that has already been hit on the opponent's board" do
      xit "fails" do
      end
    end

    context "when passed a coordinate that is invalid" do
      xit "fails" do
      end
    end
  end

  describe "#get_player_board" do
    context "when 'p1' is current_player and 'p2' is current_opponent" do
      xit "gets the board associated with the p1" do
      end

      context "then active player is switched" do
        xit "gets the board associated with the p2"
      end
    end
  end

  describe "#get_opponent_board" do
    context "when 'p1' is current_player and 'p2' is current_opponent" do
      xit "gets the board associated with the p2" do
      end

      context "then active player is switched" do
        xit "gets the board associated with the p1"
      end
    end
  end
end