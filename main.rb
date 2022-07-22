class Game

  attr_reader :board

  def initialize
    @board = Array.new(6, Array.new(7))
    @current_player_id = 0
    @players = [Player.new(self,"x", one_name()), Player.new(self, "+", two_name())]
    puts "#{current_player} will go first."
  end

  def one_name 
    print "Please enter player one's name: "
    name = gets.chomp
  end

  def two_name
    puts "Thank you."
    print "Please enter player two's name: "
    name = gets.chomp
    puts "Thank you."
    name
  end

  def current_player
    @players[@current_player_id]
  end

  def print_board
    print "  1 2 3 4 5 6 7\n"
    @board.each_with_index do |line, index|
      changed = line.map {|spot| spot.nil? ? "\u{26F6} " : spot }.join
      puts "#{index+1} #{changed}"
    end
  end
end


class Player

  def initialize(game, piece, name)
    @game = game
    @piece = piece
    @name = name
  end  

  def to_s
    "#{@name}"
  end
end

game = Game.new

game.print_board