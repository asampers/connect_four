require_relative './lib/modules.rb'
require_relative './lib/game.rb'
require_relative './lib/player.rb'

puts "Welcome! Let's play a game of Connect Four."
Game.new.play
