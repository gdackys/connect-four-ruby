require_relative "board"

class ConnectFour
  class GameFinished < StandardError
    # @param [Cell] cell
    def initialize(cell)
      super("Game finished! Winner: #{cell.value}, position: #{cell.position}")
    end
  end

  class WrongTurn < StandardError
    # @param [Cell] cell
    def initialize(cell)
      super("It's not your turn, #{cell.value}!")
    end
  end

  attr_reader :board, :win_threshold

  # @return [Cell]
  attr_reader :last_drop

  def initialize(rows = 6, columns = 7, win_threshold = 4)
    @board         = Board.new(rows, columns, nil)
    @win_threshold = win_threshold
    @last_drop     = nil
  end

  def drop(piece, column)
    raise WrongTurn.new(last_drop) if wrong_turn?(piece)
    raise GameFinished.new(last_drop) if game_finished?

    board.push_down(piece, column).tap do |cell|
      @last_drop     = cell
      @game_finished = compute_result
    end
  end

  def game_finished?
    @game_finished
  end

  def wrong_turn?(current_piece)
    last_drop&.contains?(current_piece)
  end

  def winner
    game_finished? ? last_drop.value : nil
  end

  private

  def compute_result
    last_drop.repetitions.any? { |rep_count| rep_count >= win_threshold }
  end
end
