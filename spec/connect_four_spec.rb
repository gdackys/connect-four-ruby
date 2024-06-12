require_relative "../lib/connect_four"

describe ConnectFour do
  it "X wins vertically", :aggregate_failures do
    game = ConnectFour.new

    game.put("x", 0)
    expect(game.all_done?).to eq(false)

    game.put("x", 0)
    expect(game.all_done?).to eq(false)

    game.put("x", 0)
    expect(game.all_done?).to eq(false)

    game.put("x", 0)

    expect(game.all_done?).to eq(true)
    expect(game.winner).to eq("x")
  end

  it "X wins horizontally", :aggregate_failures do
    game = ConnectFour.new

    game.put("x", 0)
    expect(game.all_done?).to eq(false)

    game.put("x", 1)
    expect(game.all_done?).to eq(false)

    game.put("x", 2)
    expect(game.all_done?).to eq(false)

    game.put("x", 3)

    expect(game.all_done?).to eq(true)
    expect(game.winner).to eq("x")
  end

  it "O wins diagonally - positive slope", :aggregate_failures do
    game = ConnectFour.new

    game.put("o", 1)
    game.put("x", 1)

    expect(game.all_done?).to eq(false)

    game.put("o", 2)
    game.put("o", 2)
    game.put("x", 2)

    expect(game.all_done?).to eq(false)

    game.put("o", 3)
    game.put("o", 3)
    game.put("o", 3)
    game.put("x", 3)

    expect(game.all_done?).to eq(false)

    game.put("o", 4)
    game.put("o", 4)
    game.put("o", 4)
    game.put("o", 4)

    expect(game.all_done?).to eq(true)
    expect(game.winner).to eq("o")
  end

  it "O wins diagonally - negative slope", :aggregate_failures do
    game = ConnectFour.new

    game.put("o", 2)
    game.put("o", 2)
    game.put("o", 2)
    game.put("o", 2)
    game.put("x", 2)

    expect(game.all_done?).to eq(false)

    game.put("o", 3)
    game.put("o", 3)
    game.put("o", 3)
    game.put("x", 3)

    expect(game.all_done?).to eq(false)

    game.put("o", 4)
    game.put("o", 4)
    game.put("x", 4)

    expect(game.all_done?).to eq(false)

    game.put("o", 5)

    expect(game.all_done?).to eq(true)
    expect(game.winner).to eq("o")
  end
end
