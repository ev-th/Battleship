require 'game'
require 'board'
require 'ship'


describe "Game integration" do
  context "initially" do
    xit "has two player names" do
    end

    xit "has a board associated with each player" do
    end
  end

  describe "#place_ship" do
    context "when a ship is placed on valid coordinates of the player board" do
      xit "updates the board" do
      end

      xit "moves the ship to placed_ships" do
      end

      xit "removes the ship from unplaced_ships" do
      end
    end
    
    context "when a ship is placed out of bounds" do
      xit "fails" do
      end
    end

    context "when a ship is placed on top of another ship on the player board" do
      xit "fails" do
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