require "game_maker"

RSpec.describe GameMaker do
  it "has makes a game using the game, board, and ship classes provided" do
    fake_game_class = double :fake_Game
    fake_board_class = double :fake_Board
    fake_ship_class = double :fake_Ship

    ship_1 = double :ship_1
    ship_2 = double :ship_2
    ship_3 = double :ship_3
    ship_4 = double :ship_4
    ship_5 = double :ship_5
    ship_6 = double :ship_6
    ship_7 = double :ship_7
    ship_8 = double :ship_8
    ship_9 = double :ship_9
    ship_10 = double :ship_10

    ships_1 = [ship_1, ship_2, ship_3, ship_4, ship_5]
    ships_2 = [ship_6, ship_7, ship_8, ship_9, ship_10]

    board_1 = double :board_1
    board_2 = double :board_2
    
    expect(fake_ship_class).to receive(:new).with(5).and_return(ship_1)
    expect(fake_ship_class).to receive(:new).with(4).and_return(ship_2)
    expect(fake_ship_class).to receive(:new).with(3).and_return(ship_3)
    expect(fake_ship_class).to receive(:new).with(3).and_return(ship_4)
    expect(fake_ship_class).to receive(:new).with(2).and_return(ship_5)
    
    expect(fake_board_class).to receive(:new).with(ships_1).and_return(board_1)
    
    expect(fake_ship_class).to receive(:new).with(5).and_return(ship_6)
    expect(fake_ship_class).to receive(:new).with(4).and_return(ship_7)
    expect(fake_ship_class).to receive(:new).with(3).and_return(ship_8)
    expect(fake_ship_class).to receive(:new).with(3).and_return(ship_9)
    expect(fake_ship_class).to receive(:new).with(2).and_return(ship_10)
    
    expect(fake_board_class).to receive(:new).with(ships_2).and_return(board_2)
    
    fake_game = double :fake_game
    expect(fake_game_class).to receive(:new).with(board_1, board_2).and_return(fake_game)
    
    game_maker = GameMaker.new(fake_game_class, fake_board_class, fake_ship_class)
    game = game_maker.make_game
    expect(game).to eq fake_game

  end


end