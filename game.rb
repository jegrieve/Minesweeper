require_relative "board"
require_relative "player"
class Game
    attr_accessor :board
    def initialize(name = "player 1")
        @board = Board.new
        @player = Player.new(name)
    end

    def run
        #V1
        #Get position
        #If bomb, game over, else continue
        #keep going until bomb or all non-bomb spaces cleared.
        until game_complete? #all positions that are non-bombs are filled
            display
            pos = @player.get_input

            while !valid_pos?(pos)
                puts "not valid (0-8 only)"
                pos = @player.get_input
            end

            place(pos)
             if bomb?(pos)
                display
                lose
                return
             end

        end
        puts "You win!"
        #V1 just select positions and if not bomb, then keep going until bomb or all squares are filled except bombs.
        #show board  DISPLAY ON GAME.RB
        #get input from user GET_INPUT ON PLAYER.RB
        #if user input is on BOMB, game over!
        # if user input is not on bomb, clear all areas before bomb.
    end

    def lose
        puts "you lose!!" 
    end

    def display
        @board.display
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

        #to-do:
    #counts on adjacent bombs
    #number on tiles next to adjacent bombs
    #flagging
end

Game.new.run