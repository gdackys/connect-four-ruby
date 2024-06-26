class Cell
  attr_accessor :value, :position,

                # @return [Cell]
                :top_left,

                # @return [Cell]
                :top,

                # @return [Cell]
                :top_right,

                # @return [Cell]
                :left,

                # @return [Cell]
                :right,

                # @return [Cell]
                :bottom_left,

                # @return [Cell]
                :bottom,

                # @return [Cell]
                :bottom_right

  # @return [Array<Array<Cell>>]
  def self.grid(rows, columns, value)
    grid = Array.new(columns) { Array.new(rows) { Cell.new(value) } }

    max_c = columns - 1
    max_r = rows - 1

    columns.times do |c|
      rows.times do |r|
        cell = grid[c][r]

        cell.position     = [c, r]

        cell.top_left     = grid[c - 1][r - 1] if c > 0 && r > 0
        cell.top          = grid[c][r - 1] if r > 0
        cell.top_right    = grid[c + 1][r - 1] if c < max_c && r > 0

        cell.right        = grid[c + 1][r] if c < max_c

        cell.bottom_right = grid[c + 1][r + 1] if c < max_c && r < max_r
        cell.bottom       = grid[c][r + 1] if r < max_r
        cell.bottom_left  = grid[c - 1][r + 1] if c > 0 && r < max_r

        cell.left         = grid[c - 1][r] if c > 0
      end
    end

    grid
  end

  def initialize(value)
    @value = value
  end

  # @return [Cell, nil]
  def neighbour(direction)
    send(direction)
  end

  def repetitions
    [
      horizontal_repetitions,
      vertical_repetitions,
      asc_diagonal_repetitions,
      desc_diagonal_repetitions,
    ]
  end

  def horizontal_repetitions
    return 0 if empty?
    count_repetitions(:left) + count_repetitions(:right) + 1
  end

  def vertical_repetitions
    return 0 if empty?
    count_repetitions(:top) + count_repetitions(:bottom) + 1
  end

  def asc_diagonal_repetitions
    return 0 if empty?
    count_repetitions(:bottom_left) + count_repetitions(:top_right) + 1
  end

  def desc_diagonal_repetitions
    return 0 if empty?
    count_repetitions(:top_left) + count_repetitions(:bottom_right) + 1
  end

  def push_down(value)
    push_value(value, :bottom)
  end

  def empty?
    value.nil?
  end

  def contains?(value)
    return false if empty?
    self.value == value
  end

  def inspect
    "#<Cell:#{__id__} @value=#{@value} @position=#{@position}>"
  end

  private

  # @return [Cell]
  def push_value(value, direction)
    cell = last_empty(direction)

    if cell
      cell.value = value
      cell
    end
  end

  # @return [Cell, nil]
  def last_empty(direction)
    cell = self
    memo = nil

    loop do
      if cell&.empty?
        memo = cell
        cell = cell.neighbour(direction)
      else
        break memo
      end
    end
  end

  # @return [Integer]
  def count_repetitions(direction)
    cell  = neighbour(direction)
    count = 0

    loop do
      if cell && cell.contains?(value)
        count += 1
        cell  = cell.neighbour(direction)
      else
        break count
      end
    end
  end
end
