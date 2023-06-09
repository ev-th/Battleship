require 'board'

RSpec.describe Board do
  context "initially" do
    it "has an empty grid" do
      board = Board.new([])
      expected_grid = [
        [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
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
      expect(board.grid).to eq expected_grid
    end

    describe "#all_ships_sunk?" do
      it "fails" do
        board = Board.new([])
        expect { board.all_ships_sunk? }.to raise_error "There are no ships on the board."
      end
    end

    context "when passed an empty array" do
      it "has no unplaced ships" do
        board = Board.new([])
        expect(board.unplaced_ships).to eq []
      end

      it "has no placed ships" do
        board = Board.new([])
        expect(board.placed_ships).to eq []
      end
    end

    context "when passed an array of ships" do
      it "holds them as unplaced ships" do
        ship1 = double :ship1
        ship2 = double :ship2
        board = Board.new([ship1, ship2])
        expect(board.unplaced_ships).to eq [ship1, ship2]
      end

      it "has no placed ships" do
        board = Board.new([])
        expect(board.placed_ships).to eq []
      end
    end
  end

  describe "#place_ship" do
    context "when passed a ship length that is not available" do
      it "fails" do
        fake_ship_1 = double :fake_ship_1, length: 3
        fake_ship_2 = double :fake_ship_2, length: 4
        board = Board.new([fake_ship_1, fake_ship_2])
        expect {
          board.place_ship(2, "C3", "horizontal")
        }.to raise_error "There are no ships of this length available to place."
      end
    end

    context "when passed a coordinate that is too far to the right" do
      it "fails" do
        fake_ship_1 = double :fake_ship_1, length: 3
        fake_ship_2 = double :fake_ship_2, length: 4
        board = Board.new([fake_ship_1, fake_ship_2])
        expect {
          board.place_ship(3, "K3", "vertical")
        }.to raise_error "This is an invalid coordinate."
      end
    end

    context "when passed a coordinate that is too far down" do
      it "fails" do
        fake_ship_1 = double :fake_ship_1, length: 3
        fake_ship_2 = double :fake_ship_2, length: 4
        board = Board.new([fake_ship_1, fake_ship_2])
        expect {
          board.place_ship(3, "B11", "vertical")
        }.to raise_error "This is an invalid coordinate."
      end
    end
    
    context "when passed an invalid orientation" do
      it "fails" do
        fake_ship_1 = double :fake_ship_1, length: 3
        fake_ship_2 = double :fake_ship_2, length: 4
        board = Board.new([fake_ship_1, fake_ship_2])
        expect {
          board.place_ship(3, "B10", "diagonal")
        }.to raise_error "This is an invalid orientation."
      end
    end

    context "when given coordinate A1 (uppercase)" do
      it "places the ship in the top left corner" do
        fake_ship = double :fake_ship, length: 2
        board = Board.new([fake_ship])
        board.place_ship(2, "A1", "horizontal")
        result = board.grid

        expected_result = [
          [{ship: fake_ship, hit: false}, {ship: fake_ship, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
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

        expect(result).to eq expected_result
      end
    end
    
    context "when given coordinate a1 (lowercase)" do
      it "places the ship in the top left corner" do
        fake_ship = double :fake_ship, length: 3
        board = Board.new([fake_ship])
        board.place_ship(3, "a1", "horizontal")
        result = board.grid
    
        expected_result = [
          [{ship: fake_ship, hit: false}, {ship: fake_ship, hit: false}, {ship: fake_ship, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
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
    
        expect(result).to eq expected_result
      end 
    end
    
    context "when given coordinate C3" do
      it "places the ship inside the grid" do
        fake_ship = double :fake_ship, length: 4
        board = Board.new([fake_ship])
        board.place_ship(4, "C3", "horizontal")
        result = board.grid
    
        expected_result = [
          [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
          [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
          [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: fake_ship, hit: false}, {ship: fake_ship, hit: false}, {ship: fake_ship, hit: false}, {ship: fake_ship, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
          [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
          [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
          [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
          [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
          [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
          [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
          [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}]
        ]
    
        expect(result).to eq expected_result
      end 
    end
    
    context "when placed at A10 horizontally" do
      it "is placed at the start of row 10" do
        fake_ship = double :fake_ship, length: 5
        board = Board.new([fake_ship])
        board.place_ship(5, "A10", "horizontal")
        result = board.grid
    
        expected_result = [
          [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
          [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
          [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
          [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
          [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
          [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
          [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
          [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
          [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
          [{ship: fake_ship, hit: false}, {ship: fake_ship, hit: false}, {ship: fake_ship, hit: false}, {ship: fake_ship, hit: false}, {ship: fake_ship, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}]
        ]
    
        expect(result).to eq expected_result
      end
    end
    
    context "when placed at J1 vertically" do
      it "is placed at the start of column J" do
        fake_ship = double :fake_ship, length: 2
        board = Board.new([fake_ship])
        board.place_ship(2, "J1", "vertical")
        result = board.grid
    
        expected_result = [
          [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: fake_ship, hit: false}],
          [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: fake_ship, hit: false}],
          [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
          [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
          [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
          [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
          [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
          [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
          [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
          [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}]
        ]
    
        expect(result).to eq expected_result
      end
    end
    
    context "when ship of length 2 is placed on I10 horizontally" do
      it "is placed at the end of row 10" do
        fake_ship = double :fake_ship, length: 2
        board = Board.new([fake_ship])
        board.place_ship(2, "I10", "horizontal")
        result = board.grid
        
        expected_result = [
          [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
          [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
          [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
          [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
          [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
          [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
          [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
          [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
          [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
          [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: fake_ship, hit: false}, {ship: fake_ship, hit: false}]
        ]
        
        expect(result).to eq expected_result
      end
    end
    
    context "when ship spills off the board to the right" do
      it "fails" do
        fake_ship = double :fake_ship, length: 3
        board = Board.new([fake_ship])
        expect {
          board.place_ship(3, "I4", "horizontal")
        }.to raise_error "Some of the ship cannot fit on the board in this position."
      end
    end
    
    context "when ship spills off the board to the bottom" do
      it "fails" do
        fake_ship = double :fake_ship, length: 4
        board = Board.new([fake_ship])
        expect {
          board.place_ship(4, "B8", "vertical")
        }.to raise_error "Some of the ship cannot fit on the board in this position."
      end
    end
    
    context "when ship is placed on top of another ship" do
      it "fails" do
        fake_ship_1 = double :fake_ship_1, length: 4
        fake_ship_2 = double :fake_ship_2, length: 3
        board = Board.new([fake_ship_1, fake_ship_2])
        board.place_ship(4, "B2", "horizontal")
        expect {
          board.place_ship(3, "C1", "vertical")
        }.to raise_error "There is already a ship placed there."
      end
    end
    
    it "removes a ship from unplaced ships" do
      fake_ship_1 = double :fake_ship_1, length: 4
      fake_ship_2 = double :fake_ship_2, length: 3
      board = Board.new([fake_ship_1, fake_ship_2])
      board.place_ship(4, "B2", "horizontal")
      expect(board.unplaced_ships).to eq [fake_ship_2]
    end
    
    it "adds the ship to placed ships" do
      fake_ship_1 = double :fake_ship_1, length: 4
      fake_ship_2 = double :fake_ship_2, length: 3
      board = Board.new([fake_ship_1, fake_ship_2])
      board.place_ship(4, "B2", "horizontal")
      expect(board.placed_ships).to eq [fake_ship_1]
    end

    context "when fails" do
      it "doesn't remove ships from unplaced_ships" do
        fake_ship_1 = double :fake_ship_1, length: 4
        board = Board.new([fake_ship_1])
        begin
          board.place_ship(2, "B3", "vertical")
        rescue RuntimeError
        end
        expect(board.unplaced_ships).to eq [fake_ship_1]
      end
      
      it "doesn't add ships to placed_ships" do
        fake_ship_1 = double :fake_ship_1, length: 4
        board = Board.new([fake_ship_1])
        begin
          board.place_ship(4, "I6", "horizontal")
        rescue RuntimeError
        end
        expect(board.placed_ships).to eq []
      end
      
      it "doesn't update the grid" do
        fake_ship_1 = double :fake_ship_1, length: 4
        fake_ship_2 = double :fake_ship_2, length: 3
        board = Board.new([fake_ship_1, fake_ship_2])
        board.place_ship(4, "c3", "horizontal")
        begin
          board.place_ship(3, "D2", "vertical")
        rescue RuntimeError
        end
        expected_grid = [
          [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
          [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
          [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: fake_ship_1, hit: false}, {ship: fake_ship_1, hit: false}, {ship: fake_ship_1, hit: false}, {ship: fake_ship_1, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
          [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
          [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
          [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
          [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
          [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
          [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
          [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}]
        ]
        expect(board.grid).to eq expected_grid
      end
    end
  end

  describe "#receive_shot" do
    context "when passed invalid coordinate" do
      it "fails" do
        board = Board.new([])
        expect {
          board.receive_shot("H12")
        }.to raise_error "This is an invalid coordinate."
      end
    end

    context "when passed a previously shot coordinate" do
      it "fails" do
        board = Board.new([])
        board.receive_shot("G6")
        expect {
          board.receive_shot("G6")
        }.to raise_error "This location has already been shot."
      end
    end
    
    it "updates the grid with the shot" do
      board = Board.new([])
      board.receive_shot("B9")
      expected_grid = [
        [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
        [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
        [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
        [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
        [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
        [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
        [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
        [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
        [{ship: nil, hit: false}, {ship: nil, hit: true}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
        [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}]
      ]
      expect(board.grid).to eq expected_grid
    end

    context "when hits a ship" do
      it "damages the ship" do
        fake_ship = double :fake_ship, length: 3, hit: nil, sunk?: false
        expect(fake_ship).to receive(:hit)
        board = Board.new([fake_ship])
        board.place_ship(3, "A5", "horizontal")
        board.receive_shot("C5")
      end
      
      context "when it partially damages the ship" do
        it "returns 'hit'" do
          fake_ship = double :fake_ship, length: 3, hit: nil, sunk?: false
          board = Board.new([fake_ship])
          board.place_ship(3, "A5", "horizontal")
          result = board.receive_shot("C5")
          expect(result).to eq "hit"
        end
      end
      
      context "when it fully damages the ship" do
        it "returns 'sunk'" do
          fake_ship = double :fake_ship, length: 3, hit: nil, sunk?: true
          board = Board.new([fake_ship])
          board.place_ship(3, "A5", "horizontal")
          result = board.receive_shot("C5")
          expect(result).to eq "sunk"
        end
      end
    end
    
    context "when it misses a ship" do
      it "returns 'miss'" do
        fake_ship = double :fake_ship, length: 3, hit: nil, sunk?: false
        board = Board.new([fake_ship])
        board.place_ship(3, "A5", "horizontal")
        result = board.receive_shot("A2")
        expect(result).to eq "miss"
      end
    end
  end

  describe "#all_ships_sunk?" do
    context "when all placed ships are not sunk" do
      it "returns false" do
        fake_ship_1 = double :fake_ship_1, length: 2, sunk?: false
        fake_ship_2 = double :fake_ship_2, length: 1, sunk?: false
        board = Board.new([fake_ship_1, fake_ship_2])
        board.place_ship(2, "A1", "horizontal")
        board.place_ship(1, "D6", "vertical")
        expect(board.all_ships_sunk?).to eq false
      end
    end

    context "when some placed ships are sunk" do
      it "returns false" do
        fake_ship_1 = double :fake_ship_1, length: 2, sunk?: false
        fake_ship_2 = double :fake_ship_2, length: 1, sunk?: true
        board = Board.new([fake_ship_1, fake_ship_2])
        board.place_ship(2, "A1", "horizontal")
        board.place_ship(1, "D6", "vertical")
        expect(board.all_ships_sunk?).to eq false
      end
    end

    context "when all placed ships are sunk" do
      it "returns true" do
        fake_ship_1 = double :fake_ship_1, length: 2, sunk?: true
        fake_ship_2 = double :fake_ship_2, length: 1, sunk?: true
        board = Board.new([fake_ship_1, fake_ship_2])
        board.place_ship(2, "A1", "horizontal")
        board.place_ship(1, "D6", "vertical")
        expect(board.all_ships_sunk?).to eq true
      end
    end
  end
end