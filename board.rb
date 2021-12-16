module GoloGoloAanda
    class Board
        attr_reader :grid
        def initialize(input = {})
            @grid = input.fetch(:grid, default_grid)
        end

        def default_grid
            row_num = 1
            Array.new(9) {Array.new(9) {Cell.new()}}.each do |row|
                elem_num = 1
                row.each do |elem|
                    if row_num.odd? && elem_num.odd?
                        elem.value = "O"
                    end
                    elem_num += 1
                end
                elem_num = 1
                row_num += 1
            end
        end

        def get_cell(x,y)
            grid[y][x]
        end

        def insert_cell(x,y, value)
            get_cell(x,y).value = value
        end

        def game_over
            return :winner if announce_result?
            false
        end

        def formatted_grid
            grid.each do |row|
              puts row.map { |cell| cell.value.empty? ? " " : cell.value }.join(" ")
            end
        end

        def count_sym(sym)
            sum = 0
            grid.each do |row|
            sum += row.count {|cell| cell.value == sym}
            end
            sum
        end

        def number_to_coordinate(number)
            mapping = {
                "1" => [1,0],
                "2" => [3,0],
                "3" => [5,0],
                "4" => [7,0],
                "10" => [1,2],
                "11" => [3,2],
                "12" => [5,2],
                "13" => [7,2],
                "19" => [1,4],
                "20" => [3,4],
                "21" => [5,4],
                "22" => [7,4],
                "28" => [1,6],
                "29" => [3,6],
                "30" => [5,6],
                "31" => [7,6],
                "37" => [1,8],
                "38" => [3,8],
                "39" => [5,8],
                "40" => [7,8],
                "5" => [0,1],
                "6" => [2,1],
                "7" => [4,1],
                "8" => [6,1],
                "9" => [8,1],
                "14" => [0,3],
                "15" => [2,3],
                "16" => [4,3],
                "17" => [6,3],
                "18" => [8,3],
                "23" => [0,5],
                "24" => [2,5],
                "25" => [4,5],
                "26" => [6,5],
                "27" => [8,5],
                "32" => [0,7],
                "33" => [2,7],
                "34" => [4,7],
                "35" => [6,7],
                "36" => [8,7],
                "41" => [1, 1],
                "42" => [3, 1],
                "43" => [5, 1],
                "44" => [7, 1],
                "45" => [1, 3],
                "46" => [3, 3],
                "47" => [5, 3],
                "48" => [7, 3],
                "49" => [1, 5],
                "50" => [3, 5],
                "51" => [5, 5],
                "52" => [7, 5],
                "53" => [1, 7],
                "54" => [3, 7],
                "55" => [5, 7],
                "56" => [7,7],
            }
            mapping[number]
        end

        def winning_positions
            [[1, 5, 6, 10], [2, 6, 7, 11], [3, 7, 8, 12], [4, 8, 9, 13], [10, 14, 15, 19], 
             [11, 15, 16, 20], [12, 16, 17, 21], [13, 17, 18, 22], [19, 23, 24, 28], [20, 24, 25, 29], [21, 25, 26, 30],
             [22, 26, 27, 31], [28, 32, 33, 37], [29, 33, 34, 38], [30, 34, 35, 39], [31, 35, 36, 40]
            ]
        end

        def place_of_symbole
            mapping_for_sym = {}
            winning_position_to_coordinate.each_with_index {|row, index| mapping_for_sym["#{index + 41}"] = row}
            return mapping_for_sym
        end

        def winning_position_to_grid()
            winning_positions.each do |row|
                row.map.with_index {|elem, index| row[index] = get_cell(number_to_coordinate(elem.to_s)[0],number_to_coordinate(elem.to_s)[1])}
            end
        end

        def winning_position_to_coordinate
            winning_positions.each do |row|
                row.map.with_index {|elem, index| row[index] = number_to_coordinate(elem.to_s)}
            end
        end

        def winning_position_values(winning_position)
            winning_position.map { |cell| cell.value }
        end

        def announce_result?
            return true if winning_position_values(winning_position_to_grid.flatten).none_empty?
            false
        end
    end
end
