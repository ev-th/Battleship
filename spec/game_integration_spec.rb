require 'game'
require 'board'
require 'ship'

describe "Game integration" do
  context "initially" do
    it "has two boards" do
      board_1 = Board.new([])
      board_2 = Board.new([])
      game = Game.new(board_1, board_2)
      expect(game.player_board).to eq board_1
      expect(game.opponent_board).to eq board_2
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
      it "records the hit on the opponent's board" do
        board_1 = Board.new([])
        board_2 = Board.new([])
        game = Game.new(board_1, board_2)
        game.shoot("A1")
        expected_grid = [
          [{ship: nil, hit: true}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
          [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
          [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
          [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
          [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
          [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
          [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
          [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
          [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
          [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}]
        ]
        
        result = game.opponent_board.grid
        expect(result).to eq expected_grid
      end
      
      context "when a ship is found at that coordinate" do
        it "damages the ship" do
          ship = Ship.new(3)
          board_1 = Board.new([])
          board_2 = Board.new([ship])
          board_2.place_ship(3, "A1", "horizontal")
          game = Game.new(board_1, board_2)
          game.shoot("A1")
          expect(ship.damage).to eq 1
        end
        
        context "if the ship is partially damaged" do
          it "returns a value to indicate a hit" do
            ship = Ship.new(3)
            board_1 = Board.new([])
            board_2 = Board.new([ship])
            board_2.place_ship(3, "A1", "horizontal")
            game = Game.new(board_1, board_2)
            result = game.shoot("A1")
            expect(result).to eq "hit"
          end
        end
        
        context "if the ship is sunk" do
          it "returns a value to indicate a ship has been sunk" do
            ship = Ship.new(3)
            board_1 = Board.new([])
            board_2 = Board.new([ship])
            board_2.place_ship(3, "A1", "horizontal")
            game = Game.new(board_1, board_2)
            game.shoot("A1")
            game.shoot("B1")
            result = game.shoot("C1")
            expect(result).to eq "sunk"
          end
        end
      end
      
      context "when a ship is not found at that coordinate" do
        it "makes no change to the opponent's ships" do
          ship = Ship.new(3)
          board_1 = Board.new([])
          board_2 = Board.new([ship])
          board_2.place_ship(3, "C3", "horizontal")
          game = Game.new(board_1, board_2)
          game.shoot("A1")
          expect(ship.damage).to eq 0
        end
        
        it "returns a value to indicate a miss" do
          board_1 = Board.new([])
          board_2 = Board.new([])
          game = Game.new(board_1, board_2)
          result = game.shoot("B1")
          expect(result).to eq "miss"
        end
      end
    end
    
    context "when passed a coordinate that has already been hit on the opponent's board" do
      it "fails" do
        board_1 = Board.new([])
        board_2 = Board.new([])
        game = Game.new(board_1, board_2)
        game.shoot("A1")
        expect {
          game.shoot("A1")
        }.to raise_error "This location has already been shot."
      end
    end
    
    context "when passed a coordinate that is invalid" do
      it "fails" do
        board_1 = Board.new([])
        board_2 = Board.new([])
        game = Game.new(board_1, board_2)
        expect {
          game.shoot("K1")
        }.to raise_error "This is an invalid coordinate."
      end
    end
  end
  
  describe "#switch_active_player" do
    it "switches the boards" do
      ship_1 = Ship.new(2)
      ship_2 = Ship.new(3)
      board_1 = Board.new([ship_1, ship_2])

      ship_3 = Ship.new(3)
      ship_4 = Ship.new(4)
      board_2 = Board.new([ship_3, ship_4])

      game = Game.new(board_1, board_2)

      game.place_ship(2, "A1", "horizontal")
      game.place_ship(3, "C1", "vertical")
      game.switch_active_player
      
      game.place_ship(3, "D6", "horizontal")
      game.place_ship(4, "B10", "horizontal")
      game.switch_active_player
      
      game.shoot("A1")
      game.switch_active_player
      game.shoot("A1")
      game.switch_active_player
      game.shoot("c10")

      
      expected_grid_1 = [
        [{ship: ship_1, hit: true}, {ship: ship_1, hit: false}, {ship: ship_2, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
        [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: ship_2, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
        [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: ship_2, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
        [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
        [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
        [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
        [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
        [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
        [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
        [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}]
      ]

      expected_grid_2 = [
        [{ship: nil, hit: true}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
        [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
        [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
        [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
        [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
        [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: ship_3, hit: false}, {ship: ship_3, hit: false}, {ship: ship_3, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
        [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
        [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
        [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
        [{ship: nil, hit: false}, {ship: ship_4, hit: false}, {ship: ship_4, hit: false}, {ship: ship_4, hit: false}, {ship: ship_4, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}]
      ]

      expect(board_1.grid).to eq expected_grid_1

    end
  end
end