class Board
  attr_reader :grid, :unplaced_ships, :placed_ships

  def initialize(ships)
    @unplaced_ships = ships
    @placed_ships = []
    @grid = make_grid
  end

  def place_ship(ship_length, start_position, orientation)
    available_ship_lengths = @unplaced_ships.map(&:length)
    unless available_ship_lengths.include?(ship_length)
      fail "There are no ships of this length available to place."
    end

    valid_columns = [
      "A", "B", "C", "D", "E", "F", "G", "H", "I", "J",
      "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", 
    ]
    column = start_position[0]
    unless valid_columns.include? column
      fail "This is an invalid coordinate."
    end

    row = start_position[1..-1]
    unless row.match(/[0-9]+/)
      fail "This is an invalid coordinate."
    end

    unless row.to_i <= 10
      fail "This is an invalid coordinate."
    end

    unless ["horizontal", "vertical"].include?(orientation)
      fail "This is an invalid orientation."
    end

    column_index = start_position[0].upcase.ord - 65
    row_index = start_position[1..-1].to_i - 1

    if orientation == "vertical"
      last_row_index = row_index + ship_length - 1
      last_column_index = column_index
    elsif orientation == "horizontal"
      last_row_index = row_index
      last_column_index = column_index + ship_length - 1
    end

    if last_row_index >= 10 || last_column_index >= 10
      fail "Some of the ship cannot fit on the board in this position."
    end

    if orientation == "vertical"
      unless (row_index..last_row_index).all? {|i| @grid[i][column_index][:ship].nil?}
        fail "There is already a ship placed there."
      end
    elsif orientation == "horizontal"
      unless (column_index..last_column_index).all? {|i| @grid[row_index][i][:ship].nil?}
        fail "There is already a ship placed there."
      end
    end

    ship_index = @unplaced_ships.index { |ship| ship.length == ship_length}
    ship = @unplaced_ships.delete_at(ship_index)
    @placed_ships << ship


    ship_length.times do
      @grid[row_index][column_index][:ship] = ship
      if orientation == 'vertical'
        row_index += 1
      elsif orientation == 'horizontal'
        column_index += 1
      end
    end
  end

  def receive_shot
  end

  def all_ships_sunk?
    false
  end

  private

  def make_grid
    [
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
  end
end

# [
#   [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
#   [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
#   [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
#   [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
#   [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
#   [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
#   [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
#   [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
#   [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}],
#   [{ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}, {ship: nil, hit: false}]
# ]