class BoardFormatter

  def initialize(board)
    @board = board
  end

  def format_as_player
    format_grid("ships")
  end

  def format_as_opponent
    format_grid("hits")
  end

  private

  def format_grid(type)
    result = "  | A | B | C | D | E | F | G | H | I | J |\n" + 
    "--|---+---+---+---+---+---+---+---+---+---|\n"

    rows = @board.grid.each_with_index.map do |row, i|
      row_number = i + 1
      space_after_number = row_number < 10 ? " " : ""
      formatted_row = format_row(type, row)

      "#{row_number}#{space_after_number}#{formatted_row}"
    end

    result += rows.join("\n--|---+---+---+---+---+---+---+---+---+---|\n")
    result + "\n------------------------------------------+"
  end

  def ship_row_to_chars(row)
    row.map { |coord| coord[:ship].nil? ? " " : "S"}
  end

  def hit_row_to_chars(row)
    row.map { |coord| coord[:hit] ? "X" : " "}
  end

  def format_row(type, row)
    chars = type == "ships" ? ship_row_to_chars(row) : hit_row_to_chars(row)
    "| #{chars.join(" | ")} |"
  end
end