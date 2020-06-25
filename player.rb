class Player
    def initialize(name)
        @name = name
    end

    def get_input
        puts "#{@name} please enter an input. (Ex: 0 0 for first position)"
        pos = gets.chomp.split(" ").map(&:to_i)
    end
end 