class ConnectFour
  def initialize(rows = 6, columns = 7, to_win = 4)
    @rows_num = rows
    @columns_num = columns
    @to_win = to_win

    @rows = Array.new(rows) { Array.new(columns, ".") }
    @last_drop = {column: nil, row_index: nil, piece: nil}
  end

  def put(piece, column)
    @rows.each_with_index do |row, row_index|
      if row[column] == "."
        row[column] = piece
        @last_drop = {column:, row_index:, piece:}
        break
      else
        next
      end
    end
  end

  def all_done?
    done_vertically? || done_horizontally? || done_diagonally?
  end

  def done_vertically?
    column = @rows.map { |row| row[@last_drop[:column]] }
    done?(column)
  end

  def done_horizontally?
    row = @rows[@last_drop[:row_index]]
    done?(row)
  end

  def done_diagonally?
    done?(positive_slope) || done?(negative_slope)
  end

  def positive_slope
    distance_from_edge = [@last_drop[:column], @last_drop[:row_index]].min
    edge_row = @last_drop[:row_index] - distance_from_edge
    edge_col = @last_drop[:column] - distance_from_edge

    cell = @rows[edge_row][edge_col]
    cells = []

    until cell.nil?
      cells.push(cell)
      edge_row += 1
      edge_col += 1
      cell = @rows.fetch(edge_row, []).fetch(edge_col, nil)
    end

    cells
  end

  def negative_slope
    row_index_max = @rows.size - 1
    distance_from_top = row_index_max - @last_drop[:row_index]
    distance_from_edge = [@last_drop[:column], distance_from_top].min
    edge_row = @last_drop[:row_index] + distance_from_edge
    edge_col = @last_drop[:column] - distance_from_edge

    cell = @rows[edge_row][edge_col]
    cells = []

    until cell.nil?
      cells.push(cell)
      edge_row -= 1
      edge_col += 1
      cell = @rows.fetch(edge_row, []).fetch(edge_col, nil)
    end

    cells
  end

  def winner
    @last_drop[:piece]
  end

  private

  def done?(cells)
    @to_win == cells.inject(0) do |count, piece|
      case piece
      when @last_drop[:piece]
        count + 1
      when "."
        count
      else
        0
      end
    end
  end
end
