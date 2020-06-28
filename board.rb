require_relative "tile.rb"
class Board
    attr_accessor :grid, :grid_play
    def initialize
        @grid = Array.new(9) {Array.new(9)}
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
                @grid[i1][i2] = Tile.new
                @grid[i1][i2].value = bombs.sample
            end
        end
    end

    def set_pos(pos)
        row, col = pos
        if @grid[row][col].value == " " && @grid[row][col].count == 0
            @grid_play[row][col] = "X"
        elsif @grid[row][col].value == " " && @grid[row][col].count != 0
            @grid_play[row][col] = "#{@grid[row][col].count}"
        else
            @grid_play[row][col] = "B"
            "B"
        end
    end

    def set_adjacent(pos)
        row, col = pos
        @grid[row][col]
    end

    def adj_left(pos)

    end

    def adj_left(pos)

    end

    def adj_up(pos)

    end

    def adj_down(pos)

    end


    #Todo
    #Set_adjacent should set tiles around the set_tile
    #If the adjacent_tile is anything other than 0 we put its count and stop
    #If the adjacent_tile has a count of 0, we set as "X" and then set_adjacent to that tile
    #**Also remember to stop set_adjacent from looking at previous set tiles,
    #by making a requirement that @grid_play[pos] == " "

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
        tile = @grid[row][col] 
        count += left?(pos)
        count += right?(pos)
        count += up?(pos)
        count += down?(pos)
        tile.count = count
    end

    def left?(pos)
        count = 0
        row, col = pos
        return 0 if col == 0
        left = col - 1
        if valid_pos?([row, left])
            count += 1 if @grid[row][left].value == "B"
        end
        count
    end

    def right?(pos)
        count = 0
        row, col = pos
        return 0 if col == 8
        right = col + 1
        if valid_pos?([row, right])
            count += 1 if @grid[row][right].value == "B"
        end
        count
    end

    def up?(pos)
        count = 0
        row, col = pos
        return 0 if row == 0
        upper = row - 1
        count += 1 if @grid[upper][col].value == "B"
        count += left?([upper, col])
        count += right?([upper, col])
        count   
    end

    def down?(pos)
        count = 0
        row, col = pos
        return 0 if row == 8
        lower= row + 1
        count += 1 if @grid[lower][col].value == "B"
        count += left?([lower, col])
        count += right?([lower, col])
        count 
    end

    def valid_pos?(pos)
        row, col = pos
        @grid[row][col] != nil
    end
end

# p = Board.new
# p.display
# p = Board.new
# p.adjacent_tiles([0,8])

