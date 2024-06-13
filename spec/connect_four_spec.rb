require_relative "../lib/connect_four"

describe ConnectFour do
  let(:connect4) { ConnectFour.new }

  it "X wins vertically", :aggregate_failures do
    connect4.drop("x", 0)
    connect4.drop("o", 1)

    connect4.drop("x", 0)
    connect4.drop("o", 1)

    connect4.drop("x", 0)
    connect4.drop("o", 1)

    connect4.drop("x", 0)

    expect(connect4.game_finished?).to eq(true)
    expect(connect4.winner).to eq("x")
  end

  xit "X wins horizontally", :aggregate_failures do
    connect4.drop("x", 0)
    connect4.drop("x", 1)
    connect4.drop("x", 2)
    connect4.drop("x", 3)

    expect(connect4.game_finished?).to eq(true)
    expect(connect4.winner).to eq("x")
  end

  xit "O wins diagonally - positive slope", :aggregate_failures do
    connect4.drop("o", 1)
    connect4.drop("x", 1)

    connect4.drop("o", 2)
    connect4.drop("o", 2)
    connect4.drop("x", 2)

    connect4.drop("o", 3)
    connect4.drop("o", 3)
    connect4.drop("o", 3)
    connect4.drop("x", 3)

    connect4.drop("o", 4)
    connect4.drop("o", 4)
    connect4.drop("o", 4)
    connect4.drop("o", 4)

    expect(connect4.game_finished?).to eq(true)
    expect(connect4.winner).to eq("o")
  end

  xit "O wins diagonally - negative slope", :aggregate_failures do
    connect4.drop("o", 2)
    connect4.drop("o", 2)
    connect4.drop("o", 2)
    connect4.drop("o", 2)
    connect4.drop("x", 2)

    connect4.drop("o", 3)
    connect4.drop("o", 3)
    connect4.drop("o", 3)
    connect4.drop("x", 3)

    connect4.drop("o", 4)
    connect4.drop("o", 4)
    connect4.drop("x", 4)

    connect4.drop("o", 5)

    expect(connect4.game_finished?).to eq(true)
    expect(connect4.winner).to eq("o")
  end
end
