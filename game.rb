module GoloGoloAanda
    class Game
        attr_reader :players, :board, :current_player, :other_player
        def initialize(players, board = Board.new)
            @players = players
            @board = board
            @current_player, @other_player = players.shuffle
        end

        def switch_players
            @current_player, @other_player = @other_player, @current_player
        end

        def solicit_move
            "#{current_player.name}: Enter a number between 1 and 40 to make your move"
        end

        def get_move(human_move = gets.chomp)
            board.number_to_coordinate(human_move)
        end

        def possible_closing(move)
            board.place_of_symbole.select {|key, row| row.include?(move)}
        end

        def possible_closing_grid(move)
            possible_closing(move).each_pair do |key, row|
                row.map.with_index do |elem, index|
                    row[index] = board.get_cell(elem[0],elem[1])
                end
            end
        end

        def possible_closing_values(move)
            a = {}
            possible_closing_grid(move).each_pair {|key, row|a[key] = board.winning_position_values(row)}
            a
        end

        def closing_values(move)
            possible_closing_values(move).select{|key, row| row.none_empty?}
        end

        def insert_sym?(move)
            if closing_values(move).length != 0
                return true
            else
                return false
            end
        end

        def grid_to_place_sym(move)
            
        
        end
        def play
            puts "#{current_player.name} has randomly been selected as the first player"
            while true
              board.formatted_grid
              puts ""
              puts solicit_move
              move = get_move
              x, y = move
              board.insert_cell(x, y, "-")
              puts closing_values(move)
              if insert_sym?(move)
                closing_values(move).each_key do |key|
                    c, d = board.number_to_coordinate(key)
                    board.insert_cell(c, d, current_player.sym)
                    puts board.count_sym('X')
                end
              else
                switch_players
              end

              if board.announce_result?
                if board.count_sym(current_player.sym) > board.count_sym(other_player.sym)
                    puts "#{current_player.name} is winner"
                elsif board.count_sym(current_player.sym) < board.count_sym(other_player.sym)
                    puts "#{other_player.name} is winner"
                else
                    puts "It is draw"
                end
                board.formatted_grid
                return
              end
            end
        end
    end
end