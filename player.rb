class Player
    def initialize(name)
        @name = name
    end

    def get_input
        puts "#{@name} please enter an input. (Ex: 0 0 for first position)"
        pos = gets.chomp.split(" ").map(&:to_i)
    end

    def choose_input
        puts "Check Position (enter P) or Place Flag (enter F)"
        input = gets.chomp.upcase
    end
end 

