require_relative "../lib/board"

describe Board do
  describe ".cells" do
    let(:grid) { Board.cells(3, 3, 0) }

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

  describe "#push_down" do
    let(:grid) { Board.new(3, 3, nil) }

    describe "#push_down" do
      before do
        grid.push_down(1, 0)
        grid.push_down(2, 0)
        grid.push_down(3, 0)

        grid.push_down(4, 1)
        grid.push_down(5, 1)
        grid.push_down(6, 1)

        grid.push_down(7, 2)
        grid.push_down(8, 2)
        grid.push_down(9, 2)
      end

      it "pushes correct value to col:0 row:0" do
        expect(grid.value_at(0, 0)).to eq(3)
      end

      it "pushes correct value to col:0 row:1" do
        expect(grid.value_at(0, 1)).to eq(2)
      end

      it "pushes correct value to col:0 row:2" do
        expect(grid.value_at(0, 2)).to eq(1)
      end

      it "pushes correct value to col:1 row:0" do
        expect(grid.value_at(1, 0)).to eq(6)
      end

      it "pushes correct value to col:1 row:1" do
        expect(grid.value_at(1, 1)).to eq(5)
      end

      it "pushes correct value to col:1 row:2" do
        expect(grid.value_at(1, 2)).to eq(4)
      end

      it "pushes correct value to col:2 row:0" do
        expect(grid.value_at(2, 0)).to eq(9)
      end

      it "pushes correct value to col:2 row:1" do
        expect(grid.value_at(2, 1)).to eq(8)
      end

      it "pushes correct value to col:2 row:2" do
        expect(grid.value_at(2, 2)).to eq(7)
      end
    end
  end
end
