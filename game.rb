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
        until complete? #all positions that are non-bombs are filled


        end
        puts "You win!"
        #V1 just select positions and if not bomb, then keep going until bomb or all squares are filled except bombs.
        #show board  DISPLAY ON GAME.RB
        #get input from user GET_INPUT ON PLAYER.RB
        #if user input is on BOMB, game over!
        # if user input is not on bomb, clear all areas before bomb.
    end

    def display
        @board.display
    end

    def place(pos) #ex [0,0]
        @board.set_pos(pos)
    end

    def complete?
        @board.complete?
    end

end

g = Game.new
g.board.populate
g.place([0,0])
g.display