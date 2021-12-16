require_relative "cell.rb"
require_relative "board.rb"
require_relative "core-extensions.rb"
require_relative "game.rb"
require_relative "player.rb"

play_again = true
puts "Welcome to tic tac toe"
puts "Enter the name of player 1"
player_1 = gets.chomp
puts "Enter the name of player 2"
player_2 = gets.chomp
player_1 = GoloGoloAanda::Player.new({sym: "X", name: player_1})
player_2 = GoloGoloAanda::Player.new({sym: "O", name: player_2})
players = [player_1, player_2]
GoloGoloAanda::Game.new(players).play