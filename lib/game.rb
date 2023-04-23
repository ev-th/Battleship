class Game
  attr_reader :player_board, :opponent_board

  def initialize(board1, board2)
    @player_board = board1
    @opponent_board = board2
  end

  def place_ship(ship_length, position, orientation)
    @player_board.place_ship(ship_length, position, orientation)
  end

  def get_remaining_unplaced_ships
    player_board.unplaced_ships
  end

  def shoot(coordinates)
    @opponent_board.receive_shot(coordinates)
  end

  def switch_active_player
    @player_board, @opponent_board = @opponent_board, @player_board
  end
end