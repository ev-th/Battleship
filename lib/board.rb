class Board
  attr_reader :grid, :unplaced_ships, :placed_ships

  def initialize(ships)
    @unplaced_ships = ships
    @placed_ships = []
    @grid = make_grid
  end

  def place_ship(ship_length, start_position, orientation)
    unless @unplaced_ships.map(&:length).include?(ship_length)
      fail "There are no ships of this length available to place."
    end

    unless is_valid_coordinates?(start_position)
      fail "This is an invalid coordinate."
    end

    unless ["horizontal", "vertical"].include?(orientation)
      fail "This is an invalid orientation."
    end

    row_index, column_index = convert_coordinates(start_position)

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

  def receive_shot(coordinates)
    fail "This is an invalid coordinate." unless is_valid_coordinates?(coordinates)

    row_index, column_index = convert_coordinates(coordinates)
    grid_location = @grid[row_index][column_index]

    fail "This location has already been shot." if grid_location[:hit]

    grid_location[:hit] = true

    ship = grid_location[:ship]
    return "miss" if ship.nil?

    ship.hit
    ship.sunk? ? "sunk" : "hit"
  end

  def all_ships_sunk?
    fail "There are no ships on the board." if @placed_ships.empty?
    @placed_ships.all?(&:sunk?)
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

  def is_valid_coordinates?(coordinates)
    valid_columns = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J"]
    column = coordinates[0].upcase

    valid_rows = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
    row = coordinates[1..-1]

    valid_columns.include?(column) && valid_rows.include?(row)
  end

  def convert_coordinates(coordinates)
    column_index = coordinates[0].upcase.ord - 65
    row_index = coordinates[1..-1].to_i - 1
    [row_index, column_index]
  end
end