require 'game'

RSpec.describe Game do
  context "initially" do
    it "has has a player board" do
      fake_board_1 = double :fake_board_1
      fake_board_2 = double :fake_board_2
      game = Game.new(fake_board_1, fake_board_2)
      expect(game.player_board).to eq fake_board_1
    end

    it "has an opponent board" do
      fake_board_1 = double :fake_board_1
      fake_board_2 = double :fake_board_2
      game = Game.new(fake_board_1, fake_board_2)
      expect(game.opponent_board).to eq fake_board_2
    end
  end
  
  describe "#place_ship" do
    it "places a ship on the player board" do
      fake_board_1 = double :fake_board_1
      fake_board_2 = double :fake_board_2
      game = Game.new(fake_board_1, fake_board_2)
      expect(fake_board_1).to receive(:place_ship).with(3, "A1", "vertical")
      game.place_ship(3, "A1", "vertical")
    end
  end
  
  describe "#get_remaining_unplaced_ships" do
    it "gets the unplaced ships from the player_board" do
      fake_ship = double :fake_ship
      fake_board_1 = double :fake_board_1, unplaced_ships: [fake_ship]
      fake_board_2 = double :fake_board_2
      game = Game.new(fake_board_1, fake_board_2)
      result = game.get_remaining_unplaced_ships
      expect(result).to eq [fake_ship]
    end
  end

  describe "#shoot" do
    it "shoots at the opponent board" do
      fake_board_1 = double :fake_board_1
      fake_board_2 = double :fake_board_2
      game = Game.new(fake_board_1, fake_board_2)
      expect(fake_board_2).to receive(:receive_shot).with("a1")
      game.shoot("a1")
    end
  end
  
  describe "#switch_active_player" do
    it "switches the boards" do
      fake_board_1 = double :fake_board_1
      fake_board_2 = double :fake_board_2
      game = Game.new(fake_board_1, fake_board_2)
      game.switch_active_player
      expect(game.player_board).to eq fake_board_2
      expect(game.opponent_board).to eq fake_board_1
    end

    it "switches the boards back again" do
      fake_board_1 = double :fake_board_1
      fake_board_2 = double :fake_board_2
      game = Game.new(fake_board_1, fake_board_2)
      game.switch_active_player
      game.switch_active_player
      expect(game.player_board).to eq fake_board_1
      expect(game.opponent_board).to eq fake_board_2
    end
  end
end