class Player
    def initialize(name)
        @name = name
    end

    def get_input
        #please enter position ex: 0 0
        pos = gets.chomp.split("").map(&:to_i)
    end
end 