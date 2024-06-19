require_relative "cell"

class Board
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
