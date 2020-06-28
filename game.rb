require_relative "board"
require_relative "player"
class Game
    attr_accessor :board
    def initialize(name = "player 1")
        @board = Board.new
        @player = Player.new(name)
    end

            #to-do:
    #Refactor for V2 of board 
    #Instead of placing X, place tile.count. If tile.count == 0 then we place an X. Board should have number on each tile for V2.
    #number on tiles next to adjacent bombs
    #algorithm to clear all tiles not adjacent to other bombs

    def run
        until game_complete?
            display
            
            input = @player.choose_input

            pos = @player.get_input
            @board.adjacent_tiles(pos)
            while !valid_input?(input)
                puts "not valid (P or F only)"
                input = @player.choose_input
            end

            while !valid_pos?(pos)
                puts "not valid (0-8 only)"
                pos = @player.get_input
            end

            if input == "P"
            place(pos)
            else 
                flag(pos)
            end
            if input != "F"
             if bomb?(pos)
                display
                lose
                return
             end
            end
        end
        puts "You win!"
    end

    def lose
        puts "you lose!!" 
    end

    def display
        @board.display
    end

    def flag(pos)
        @board.set_flag(pos)
    end

    def place(pos) #ex [0,0]
        @board.set_pos(pos)
    end

    def game_complete?
        @board.complete?(game_tile_count)
    end

    def game_tile_count
        count = 0
        @board.grid_play.each do |row|
            row.each do |tile|
                count += 1 if tile == "X"
            end
        end
        count
    end

    def bomb?(pos)
        return true if place(pos) == "B"
        false
    end

    def valid_pos?(pos)
        row, col = pos
        valid_indexes = (0..8).to_a
        return false if !valid_indexes.include?(row) || !valid_indexes.include?(col)
        true
    end

    def valid_input?(input)
        valid_inputs = ["P","F"]
        return false if !valid_inputs.include?(input.upcase)
        true
    end

end

Game.new.run