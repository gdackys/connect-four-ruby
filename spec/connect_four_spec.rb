require_relative "../lib/connect_four"

describe ConnectFour do
  let(:connect4) { ConnectFour.new }

  it "doesn't accept the same piece twice" do
    connect4.drop("x", 0)
    expect { connect4.drop("x", 0) }.to raise_error(ConnectFour::WrongTurn)
  end

  context "when X wins vertically" do
    before do
      connect4.drop("x", 0)
      connect4.drop("o", 1)
      connect4.drop("x", 0)
      connect4.drop("o", 1)
      connect4.drop("x", 0)
      connect4.drop("o", 1)
      connect4.drop("x", 0)
    end

    it "finishes the game" do
      expect(connect4.game_finished?).to eq(true)
    end

    it "knows the winner" do
      expect(connect4.winner).to eq("x")
    end

    it "doesn't continue the game" do
      expect { connect4.drop("0", 3) }.to raise_error(ConnectFour::GameFinished)
    end
  end

  context "when X wins horizontally" do
    before do
      connect4.drop("x", 0)
      connect4.drop("0", 4)
      connect4.drop("x", 1)
      connect4.drop("0", 4)
      connect4.drop("x", 2)
      connect4.drop("0", 4)
      connect4.drop("x", 3)
    end

    it "finishes the game" do
      expect(connect4.game_finished?).to eq(true)
    end

    it "knows the winner" do
      expect(connect4.winner).to eq("x")
    end

    it "doesn't continue the game" do
      expect { connect4.drop("0", 4) }.to raise_error(ConnectFour::GameFinished)
    end
  end

  context "when O wins diagonally - positive slope" do
    before do
      connect4.drop("x", 3)
      connect4.drop("o", 2)
      connect4.drop("x", 1)
      connect4.drop("o", 0)

      connect4.drop("x", 3)
      connect4.drop("o", 1)
      connect4.drop("x", 2)

      connect4.drop("o", 2)
      connect4.drop("x", 3)

      connect4.drop("o", 3)
    end

    it "finishes the game" do
      expect(connect4.game_finished?).to eq(true)
    end

    it "knows the winner" do
      expect(connect4.winner).to eq("o")
    end

    it "doesn't continue the game" do
      expect { connect4.drop("x", 6) }.to raise_error(ConnectFour::GameFinished)
    end
  end

  context "when O wins diagonally - negative slope" do
    before do
      connect4.drop("x", 0)
      connect4.drop("o", 1)
      connect4.drop("x", 2)
      connect4.drop("o", 3)

      connect4.drop("x", 0)
      connect4.drop("o", 2)
      connect4.drop("x", 1)

      connect4.drop("o", 1)
      connect4.drop("x", 0)

      connect4.drop("o", 0)
    end

    it "finishes the game" do
      expect(connect4.game_finished?).to eq(true)
    end

    it "knows the winner" do
      expect(connect4.winner).to eq("o")
    end

    it "doesn't continue the game" do
      expect { connect4.drop("x", 6) }.to raise_error(ConnectFour::GameFinished)
    end
  end
end
