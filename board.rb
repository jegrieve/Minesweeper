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
        bombs = [" ", " ", " ", " ", " ", " ", "B"]
        @grid.each_with_index do |row,i1|
            row.each_with_index do |col,i2|
                @grid[i1][i2] = Tile.new
                @grid[i1][i2].value = bombs.sample
            end
        end
        add_tile_counts
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

    def add_tile_counts
        @grid.each_with_index do |row,i1|
            row.each_with_index do |col,i2|
                if col.value != "B"
                    adjacent_tiles([i1,i2])
                end
            end
        end
    end

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
        return if col == 0
        left = col - 1
         if @grid[row][left].count == 0 && @grid[row][left].value == " " && @grid_play[row][left] == " "
            set_pos([row, left])
            set_adjacent([row,left])
         elsif @grid[row][left].value == " " && @grid_play[row][left] == " "
            set_pos([row, left])
         end
    end

    def adj_right(pos)
        row, col = pos
        return if col == 8
        right = col + 1
        if @grid[row][right].count == 0 && @grid[row][right].value == " " && @grid_play[row][right] == " "
            set_pos([row, right])
            set_adjacent([row,right])
         elsif @grid[row][right].value == " " && @grid_play[row][right] == " "
            set_pos([row, right])
         end
    end



    def adj_up(pos)
        row, col = pos
        return if row == 0
        up = row - 1
        adj_upper([up,col])
        adj_right([up,col])
        adj_left([up,col])
    end

    def adj_upper(pos) 
        row, col = pos
        if @grid[row][col].count == 0 && @grid[row][col].value == " " && @grid_play[row][col] == " "
            set_pos([row, col])
            set_adjacent([row,col])
         elsif @grid[row][col].value == " " && @grid_play[row][col] == " "
            set_pos([row, col])
         end
    end

    def adj_down(pos)
        row, col = pos
        return if row == 8
        down = row + 1
        adj_lower([down,col])
        adj_right([down,col])
        adj_left([down,col])
    end

    def adj_lower(pos) 
        row, col = pos
        if @grid[row][col].count == 0 && @grid[row][col].value == " " && @grid_play[row][col] == " "
            set_pos([row, col])
            set_adjacent([row,col])
         elsif @grid[row][col].value == " " && @grid_play[row][col] == " "
            set_pos([row, col])
         end
    end

    def set_flag(pos)
        row, col = pos
        @grid_play[row][col] = "F"
    end

        #complete? method

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

    def complete?
        count = 0
        @grid_play.each do |row|
            row.each do |col|
                count += 1 if col != " "
            end
        end
        count == tile_count
    end

end

