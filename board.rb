require_relative "tile.rb"
class Board
    attr_accessor :grid, :grid_play
    def initialize
        @grid = Array.new(9) {Array.new(9, Tile.new)}
        @grid_play = Array.new(9) {Array.new(9, "")}
    end

    def display
        @grid_play.each do |row|
            p row
        end
    end

    def populate
        bombs = ["","B"]
        @grid.each.with_index do |row,i1|
            row.each_with_index do |col,i2|
                @grid[i1][i2].value = bombs.sample
            end
        end
    end
end
