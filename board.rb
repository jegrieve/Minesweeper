require_relative "tile.rb"
class Board
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
        bombs = [" ", "B"]
        @grid.each_with_index do |row,i1|
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
        end
    end
    #TODO---
    #test
    #set adjacent counts
    #set flag
    #tile counts for game completion
    #test
    #work on game class

    def adjacent_tiles(pos)
        row, col = pos
        tile = @grid[row][col]
        count = add_counts(left_count?(pos), right_count?(pos), up_count?(pos), down_count?(pos))
        tile.count = count
    end

    def left_count?(pos)
        count = 0
        row, col = pos
        return 0 if col == 0
        left = col - 1
        count += 1 if is_bomb?([row,left])
        count
    end

    def right_count?(pos)
        count = 0
        row, col = pos
        return 0 if col == 8
        right = col + 1
        count += 1 if is_bomb?([row,right])
        count
    end

    def up_count?(pos)
        row, col = pos
        return 0 if row == 0
        upper = row - 1
        count = add_counts(left_count?([upper,col]), right_count?([upper,col]), up([upper,col]))
        count
    end

    def up(pos)
        count = 0
        row, col = pos
        count += 1 if @grid[row][col].value == "B"
    end

    def down_count?(pos)
        row, col = pos
        return 0 if row == 8
        lower = row + 1
        count = add_counts(left_count?([lower,col]), right_count?([lower,col]), down([lower,col]))
        count
    end

    def down(pos)
        count = 0
        row, col = pos
        count += 1 if @grid[row][col].value == "B"
    end

    def add_counts(left, right, *updown)
        sum = left + right  
        if !updown.include?(nil)
            sum = sum + updown.sum
        end
        sum
    end

    def is_bomb?(pos)
        row, col = pos
        return true if @grid[row][col].value == "B"
        false
    end

#------------------------ Algorithm to keep solving tiles-------------
    def set_adjacent(pos)
        row, col = pos
        adjacent_tiles(pos)
        adj_left(pos)
        adj_right(pos)
        adj_up(pos)
        adj_down(pos)
    end

    def adj_left(pos)
        row, col = pos
        #we'd run adjacent tiles on tile to left
    end
end

g = Board.new
g.adjacent_tiles([0,0])

g.set_pos([0,0])

g.display