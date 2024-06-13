require_relative "cell"

class Board
  def self.cells(columns, rows, value)
    cells = Array.new(columns) { Array.new(rows) { Cell.new(value) } }

    max_c = columns - 1
    max_r = rows - 1

    columns.times do |c|
      rows.times do |r|
        cell = cells[c][r]

        cell.position     = [c, r]

        cell.top_left     = cells[c - 1][r - 1] if c > 0 && r > 0
        cell.top          = cells[c][r - 1] if r > 0
        cell.top_right    = cells[c + 1][r - 1] if c < max_c && r > 0

        cell.right        = cells[c + 1][r] if c < max_c

        cell.bottom_right = cells[c + 1][r + 1] if c < max_c && r < max_r
        cell.bottom       = cells[c][r + 1] if r < max_r
        cell.bottom_left  = cells[c - 1][r + 1] if c > 0 && r < max_r

        cell.left         = cells[c - 1][r] if c > 0
      end
    end

    cells
  end

  attr_reader :grid

  def initialize(rows, columns, value)
    @grid = self.class.cells(rows, columns, value)
  end

  def push_down(value, column_index)
    column_head(column_index).push_down(value)
  end

  def column_head(index)
    cell(index, 0)
  end

  def value_at(column, row)
    cell(column, row).value
  end

  # @return [Cell]
  def cell(col_index, row_index)
    if (column = grid[col_index])
      if (row = column[row_index])
        row
      else
        raise RangeError, "row: #{row_index} is out of range"
      end
    else
      raise RangeError, "column: #{col_index} is out of range"
    end
  end
end
