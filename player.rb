module GoloGoloAanda
    class Player
        attr_reader :name, :sym
        def initialize(input)
            @name = input.fetch(:name)
            @sym = input.fetch(:sym)
        end
    end
        
end