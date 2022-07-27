require_relative '../lib/game.rb'

class Player
  attr_reader :game, :piece, :name

  def initialize(game, piece, name)
    @game = game
    @piece = piece
    @name = name
  end  

  def select_column
    @game.print_board
    loop do 
      print "#{@name}, select a column to drop your '#{@piece}' into: "
      selection = gets.to_i
      return selection if @game.row_full?(selection) == false && selection.between?(1, 7)
      puts "Column #{selection} is already full. Try again." if @game.row_full?(selection)
      puts "Please select a number between 1 - 7." if selection != [1..7]
    end  
  end

  def to_s
    "#{@name}"
  end
end