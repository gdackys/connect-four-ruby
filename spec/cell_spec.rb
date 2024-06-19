require_relative "../lib/cell"

describe Cell do
  let(:cell1) { Cell.new(0) }
  let(:cell2) { Cell.new(1) }
  let(:cell3) { Cell.new(1) }
  let(:cell4) { Cell.new(1) }
  let(:cell5) { Cell.new(0) }

  context "with cells chained horizontally" do
    before do
      cell1.right = cell2
      cell2.right = cell3
      cell3.right = cell4
      cell4.right = cell5

      cell5.left = cell4
      cell4.left = cell3
      cell3.left = cell2
      cell2.left = cell1
    end

    describe "#count_horizontally" do
      it "returns 1 for cell1" do
        expect(cell1.horizontal_repetitions).to eq(1)
      end

      it "returns 3 for cell2" do
        expect(cell2.horizontal_repetitions).to eq(3)
      end

      it "returns 3 for cell3" do
        expect(cell3.horizontal_repetitions).to eq(3)
      end

      it "returns 3 for cell4" do
        expect(cell4.horizontal_repetitions).to eq(3)
      end

      it "returns 1 for cell5" do
        expect(cell5.horizontal_repetitions).to eq(1)
      end

      it "does not count empty cells" do
        cell1.value = nil
        cell2.value = nil
        cell3.value = nil
        cell4.value = nil
        cell5.value = nil

        expect(cell1.horizontal_repetitions).to eq(0)
      end
    end
  end

  context "with cells chained vertically" do
    before do
      cell1.bottom = cell2
      cell2.bottom = cell3
      cell3.bottom = cell4
      cell4.bottom = cell5

      cell5.top = cell4
      cell4.top = cell3
      cell3.top = cell2
      cell2.top = cell1
    end

    describe "#vertical_repetitions" do
      it "returns 1 for cell1" do
        expect(cell1.vertical_repetitions).to eq(1)
      end

      it "returns 3 for cell2" do
        expect(cell2.vertical_repetitions).to eq(3)
      end

      it "returns 3 for cell3" do
        expect(cell3.vertical_repetitions).to eq(3)
      end

      it "returns 3 for cell4" do
        expect(cell4.vertical_repetitions).to eq(3)
      end

      it "returns 1 for cell5" do
        expect(cell5.vertical_repetitions).to eq(1)
      end

      it "does not count empty cells" do
        cell1.value = nil
        cell2.value = nil
        cell3.value = nil
        cell4.value = nil
        cell5.value = nil

        expect(cell1.vertical_repetitions).to eq(0)
      end
    end
  end

  context "with cells chained diagonally - ascending" do
    before do
      cell1.top_right = cell2
      cell2.top_right = cell3
      cell3.top_right = cell4
      cell4.top_right = cell5

      cell5.bottom_left = cell4
      cell4.bottom_left = cell3
      cell3.bottom_left = cell2
      cell2.bottom_left = cell1
    end

    describe "#asc_diagonal_repetitions" do
      it "returns 1 for cell1" do
        expect(cell1.asc_diagonal_repetitions).to eq(1)
      end

      it "returns 3 for cell2" do
        expect(cell2.asc_diagonal_repetitions).to eq(3)
      end

      it "returns 3 for cell3" do
        expect(cell3.asc_diagonal_repetitions).to eq(3)
      end

      it "returns 3 for cell4" do
        expect(cell4.asc_diagonal_repetitions).to eq(3)
      end

      it "returns 1 for cell5" do
        expect(cell5.asc_diagonal_repetitions).to eq(1)
      end

      it "does not count empty cells" do
        cell1.value = nil
        cell2.value = nil
        cell3.value = nil
        cell4.value = nil
        cell5.value = nil

        expect(cell1.asc_diagonal_repetitions).to eq(0)
      end
    end
  end

  context "with cells chained diagonally - descending" do
    before do
      cell1.bottom_right = cell2
      cell2.bottom_right = cell3
      cell3.bottom_right = cell4
      cell4.bottom_right = cell5

      cell5.top_left = cell4
      cell4.top_left = cell3
      cell3.top_left = cell2
      cell2.top_left = cell1
    end

    describe "#repeats_diagonally_desc" do
      it "returns 1 for cell1" do
        expect(cell1.desc_diagonal_repetitions).to eq(1)
      end

      it "returns 3 for cell2" do
        expect(cell2.desc_diagonal_repetitions).to eq(3)
      end

      it "returns 3 for cell3" do
        expect(cell3.desc_diagonal_repetitions).to eq(3)
      end

      it "returns 3 for cell4" do
        expect(cell4.desc_diagonal_repetitions).to eq(3)
      end

      it "returns 1 for cell5" do
        expect(cell5.desc_diagonal_repetitions).to eq(1)
      end

      it "does not count empty cells" do
        cell1.value = nil
        cell2.value = nil
        cell3.value = nil
        cell4.value = nil
        cell5.value = nil

        expect(cell1.desc_diagonal_repetitions).to eq(0)
      end
    end
  end

  describe "#push_down" do
    before do
      cell1.bottom = cell2
      cell2.bottom = cell3
      cell3.bottom = cell4
      cell4.bottom = cell5
    end

    context "with no empty cells" do
      it "does nothing", :aggregate_failures do
        cell1.push_down("X")

        expect(cell1.value).to eq(0)
        expect(cell2.value).to eq(1)
        expect(cell3.value).to eq(1)
        expect(cell4.value).to eq(1)
        expect(cell5.value).to eq(0)
      end
    end

    context "with four empty cells" do
      before do
        cell1.value = nil
        cell2.value = nil
        cell3.value = nil
        cell4.value = nil
      end

      it "sets the value of the last empty cell (cell4) to X", :aggregate_failures do
        cell1.push_down("X")

        expect(cell1.value).to eq(nil)
        expect(cell2.value).to eq(nil)
        expect(cell3.value).to eq(nil)
        expect(cell4.value).to eq("X")
        expect(cell5.value).to eq(0)
      end
    end
  end

  describe ".grid" do
    let(:grid) { Cell.grid(3, 3, 0) }

    it "sets the right cell positions", :aggregate_failures do
      expect(grid[0][0].position).to eq([0, 0])
      expect(grid[0][1].position).to eq([0, 1])
      expect(grid[0][2].position).to eq([0, 2])

      expect(grid[1][0].position).to eq([1, 0])
      expect(grid[1][1].position).to eq([1, 1])
      expect(grid[1][2].position).to eq([1, 2])

      expect(grid[2][0].position).to eq([2, 0])
      expect(grid[2][1].position).to eq([2, 1])
      expect(grid[2][2].position).to eq([2, 2])
    end

    it "correctly links cell at grid[0][0]", :aggregate_failures do
      expect(grid[0][0].top_left).to eq(nil)
      expect(grid[0][0].top).to eq(nil)
      expect(grid[0][0].top_right).to eq(nil)
      expect(grid[0][0].right).to eq(grid[1][0])
      expect(grid[0][0].bottom_right).to eq(grid[1][1])
      expect(grid[0][0].bottom).to eq(grid[0][1])
      expect(grid[0][0].bottom_left).to eq(nil)
      expect(grid[0][0].left).to eq(nil)
    end

    it "correctly links cell at grid[0][1]", :aggregate_failures do
      expect(grid[0][1].top_left).to eq(nil)
      expect(grid[0][1].top).to eq(grid[0][0])
      expect(grid[0][1].top_right).to eq(grid[1][0])
      expect(grid[0][1].right).to eq(grid[1][1])
      expect(grid[0][1].bottom_right).to eq(grid[1][2])
      expect(grid[0][1].bottom).to eq(grid[0][2])
      expect(grid[0][1].bottom_left).to eq(nil)
      expect(grid[0][1].left).to eq(nil)
    end

    it "correctly links cell at grid[0][2]", :aggregate_failures do
      expect(grid[0][2].top_left).to eq(nil)
      expect(grid[0][2].top).to eq(grid[0][1])
      expect(grid[0][2].top_right).to eq(grid[1][1])
      expect(grid[0][2].right).to eq(grid[1][2])
      expect(grid[0][2].bottom_right).to eq(grid[1][3])
      expect(grid[0][2].bottom).to eq(nil)
      expect(grid[0][2].bottom_left).to eq(nil)
      expect(grid[0][2].left).to eq(nil)
    end

    it "correctly links cell at grid[1][0]", :aggregate_failures do
      expect(grid[1][0].top_left).to eq(nil)
      expect(grid[1][0].top).to eq(nil)
      expect(grid[1][0].top_right).to eq(nil)
      expect(grid[1][0].right).to eq(grid[2][0])
      expect(grid[1][0].bottom_right).to eq(grid[2][1])
      expect(grid[1][0].bottom).to eq(grid[1][1])
      expect(grid[1][0].bottom_left).to eq(grid[0][1])
      expect(grid[1][0].left).to eq(grid[0][0])
    end

    it "correctly links cell at grid[1][1]", :aggregate_failures do
      expect(grid[1][1].top_left).to eq(grid[0][0])
      expect(grid[1][1].top).to eq(grid[1][0])
      expect(grid[1][1].top_right).to eq(grid[2][0])
      expect(grid[1][1].right).to eq(grid[2][1])
      expect(grid[1][1].bottom_right).to eq(grid[2][2])
      expect(grid[1][1].bottom).to eq(grid[1][2])
      expect(grid[1][1].bottom_left).to eq(grid[0][2])
      expect(grid[1][1].left).to eq(grid[0][1])
    end

    it "correctly links cell at grid[1][2]", :aggregate_failures do
      expect(grid[1][2].top_left).to eq(grid[0][1])
      expect(grid[1][2].top).to eq(grid[1][1])
      expect(grid[1][2].top_right).to eq(grid[2][1])
      expect(grid[1][2].right).to eq(grid[2][2])
      expect(grid[1][2].bottom_right).to eq(nil)
      expect(grid[1][2].bottom).to eq(nil)
      expect(grid[1][2].bottom_left).to eq(nil)
      expect(grid[1][2].left).to eq(grid[0][2])
    end

    it "correctly links cell at grid[2][0]", :aggregate_failures do
      expect(grid[2][0].top_left).to eq(nil)
      expect(grid[2][0].top).to eq(nil)
      expect(grid[2][0].top_right).to eq(nil)
      expect(grid[2][0].right).to eq(nil)
      expect(grid[2][0].bottom_right).to eq(nil)
      expect(grid[2][0].bottom).to eq(grid[2][1])
      expect(grid[2][0].bottom_left).to eq(grid[1][1])
      expect(grid[2][0].left).to eq(grid[1][0])
    end

    it "correctly links cell at grid[2][1]", :aggregate_failures do
      expect(grid[2][1].top_left).to eq(grid[1][0])
      expect(grid[2][1].top).to eq(grid[2][0])
      expect(grid[2][1].top_right).to eq(nil)
      expect(grid[2][1].right).to eq(nil)
      expect(grid[2][1].bottom_right).to eq(nil)
      expect(grid[2][1].bottom).to eq(grid[2][2])
      expect(grid[2][1].bottom_left).to eq(grid[1][2])
      expect(grid[2][1].left).to eq(grid[1][1])
    end

    it "correctly links cell at grid[2][2]", :aggregate_failures do
      expect(grid[2][2].top_left).to eq(grid[1][1])
      expect(grid[2][2].top).to eq(grid[2][1])
      expect(grid[2][2].top_right).to eq(nil)
      expect(grid[2][2].right).to eq(nil)
      expect(grid[2][2].bottom_right).to eq(nil)
      expect(grid[2][2].bottom).to eq(nil)
      expect(grid[2][2].bottom_left).to eq(nil)
      expect(grid[2][2].left).to eq(grid[1][2])
    end
  end
end
