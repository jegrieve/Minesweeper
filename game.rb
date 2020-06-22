require_relative "board"
require_relative "player"
class Game
    def initialize(name = "player 1")
        @board = Board.new
        @player = Player.new(name)
    end

    def run
        #V1 just select positions and if not bomb, then keep going until bomb or all squares are filled except bombs.
        #show board  DISPLAY ON GAME.RB
        #get input from user GET_INPUT ON PLAYER.RB
        #if user input is on BOMB, game over!
        # if user input is not on bomb, clear all areas before bomb.
    end

    def display
        @board.display
    end

    def place
        
    end
end

Game.new.display