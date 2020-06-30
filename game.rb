require_relative "board"
require_relative "player"
class Game
    attr_accessor :board
    def initialize(name = "player 1")
        @board = Board.new
        @player = Player.new(name)
    end

    def run
        welcome
        display
        until game_complete?
            input = @player.choose_input
            while !valid_input?(input)
                puts "not valid (P or F only)"
                input = @player.choose_input
            end

            pos = @player.get_input

            while !valid_pos?(pos)
                puts "not valid (0-8 only)"
                pos = @player.get_input
            end

            if input == "P"
                place(pos)
                if bomb?(pos)
                    display
                    lose
                    return
                end
                place_adjacent(pos)
            else
                flag(pos)
            end
            display
        end
        puts "YOU WIN!!!"
    end

    def lose
        puts "YOU LOSE!!!"
    end

    def bomb?(pos)
        return true if place(pos) == "B"
        false
    end

    def display
        @board.display
    end

    def welcome
        puts "----------Welcome To Minesweeper!-----------"
    end

    def game_complete?
        return true if @board.complete?
        false
    end

    def valid_input?(input)
        valid_inputs = ["P","F"]
        return false if !valid_inputs.include?(input.upcase)
        true
    end

    
    def valid_pos?(pos)
        row, col = pos
        valid_indexes = (0..8).to_a
        return false if !valid_indexes.include?(row) || !valid_indexes.include?(col)
        true
    end

    def place(pos)
        @board.set_pos(pos)
    end

    def flag(pos)
        @board.set_flag(pos)
    end

    def place_adjacent(pos)
        @board.set_adjacent(pos)
    end
end

Game.new.run