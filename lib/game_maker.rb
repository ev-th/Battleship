class GameMaker
  def initialize(game, board, ship)
    @game = game
    @board = board
    @ship = ship
  end

  def make_game
    ships_1 = make_ships
    board_1 = make_board(ships_1)
    ships_2 = make_ships
    board_2 = make_board(ships_2)
    @game.new(board_1, board_2)
  end

  private

  def make_board(ships)
    @board.new(ships)
  end

  def make_ships
    ship_1 = @ship.new(5)
    ship_2 = @ship.new(4)
    ship_3 = @ship.new(3)
    ship_4 = @ship.new(3)
    ship_5 = @ship.new(2)
    [ship_1, ship_2, ship_3, ship_4, ship_5]
  end
end