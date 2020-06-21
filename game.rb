class Game
    def initialize(name)
        @board = Board.new
        @player = Player.new(name)
    end

    def run
        #show board
        #get input from user
        #if user input is on BOMB, game over!
        # if user input is not on bomb, clear all areas before bomb.
    end
end