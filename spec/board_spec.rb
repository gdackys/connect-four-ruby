require_relative "../lib/board"

describe Board do
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
