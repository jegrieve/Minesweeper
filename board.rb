require_relative "tile.rb"
class Board
    attr_accessor :grid, :grid_play
    def initialize
        @grid = Array.new(9) {Array.new(9, Tile.new)}
        @grid_play = Array.new(9) {Array.new(9, " ")}
        populate
    end

    def display
        @grid_play.each do |row|
            p row
        end
    end

    def populate
        bombs = [" ","B"]
        @grid.each.with_index do |row,i1|
            row.each_with_index do |col,i2|
                @grid[i1][i2].value = bombs.sample
            end
        end
    end

    def set_pos(pos)
        row, col = pos
        if @grid[row][col].value == " " || @grid[row][col].value == "X"
        @grid_play[row][col] = "X"
        "X"
        else
            @grid_play[row][col] = "B"
            "B"
        end
    end

    def tile_count
        count = 0
        @grid.each do |row|
            row.each do |tile|
            if tile.value == " "
                count += 1
            end
        end
        end
        count
    end

    def complete?(val)
        return true if val == tile_count
        false
    end

    def set_flag(pos)
        row, col = pos
        @grid_play[row][col] = "F"
    end

    def adjacent_tiles(pos)
        count = 0
        row, col = pos
        tile = @grid[row][col] #now we have acess to a tile instance
        if count > 0
            tile.count = count
        end


        #gonna check all possible tiles adj to the specific tile
        count += left?(pos)
        count += right?(pos)
        count += up?(pos)
        count += down?(pos)
        tile.count = count
        p tile.count
    end

    def left?(pos)
        count = 0
        row, col = pos
        left = col - 1
        if valid_pos?([row, left])
            count += 1 if @grid[row][left].value == "B"
        end
        count
    end

    def right?(pos)
        count = 0
        row, col = pos
        right = col + 1
        if valid_pos?([row, right])
            count += 1 if @grid[row][right].value == "B"
        end
        count
    end

    def up?(pos)
        count = 0

        row, col = pos


        count   
    end

    def down?(pos)
        count = 0

        row, col = pos


        count
    end

    def valid_pos?(pos)
        row, col = pos
        @grid[row][col] != nil
    end
end

p = Board.new
p.adjacent_tiles([0,0])

