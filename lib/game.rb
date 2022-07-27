require_relative '../lib/modules.rb'
require_relative '../lib/player.rb'

class Game
  include PlacingPieces
  include GetNames 

  attr_accessor :board

  def initialize
    @board = Array.new(6) { Array.new(7) }
    @current_player_id = 0
    @players = [Player.new(self,"x", one_name()), Player.new(self, "+", two_name())]
    puts "#{current_player} will go first."
  end

  def play
    loop do
      let_gravity_place_it(current_player)

      if player_has_won?(current_player)
        puts "That did it!"
        puts "Congrats, #{current_player}! You win!"
        print_board()
        return
      elsif board_full? 
        puts "It's a draw."
        print_board()
        return
      end 

      switch_players!()
    end        
  end

  def let_gravity_place_it(player)
    selection = player.select_column
    i = 0
    return @board[5][selection-1] = current_player.piece if @board[5][selection-1].nil?
    while i < @board.length-1
      return @board[i][selection-1] = current_player.piece if !@board[i+1][selection-1].nil?
      
      i +=1
    end  
  end

  def player_has_won?(player)
    return true if win_horizontally?(player)
    return true if win_vertically?(player)
    return true if win_diagonally?(player)
    false
  end

  def win_horizontally?(player)
    @board.each_with_index do |line, index|
      line.each_index do |ind|
        if line[ind..ind+3] == four_in_row(player)
          return true
        end  
      end
    end
    false
  end 

  def win_vertically?(player)
    @board.each_with_index do |line, index|
      line.each_index do |ind|
        combo = move_vertically(@board, index, ind)
        return true if combo == four_in_row(player) 
      end
    end
    false
  end 

  def win_diagonally?(player)
    @board.each_with_index do |line, index|
      line.each_index do |ind|
        combo = move_down_diagonally(@board, index, ind)
        combo2 = move_up_diagonally(@board, index, ind)
        return true if combo == four_in_row(player) || combo2 == four_in_row(player)
      end
    end
    false  
  end 

  def row_full?(selection)
    @board.each_with_index do |line, index|
      return false if line[selection-1].nil?
    end
    true
  end   

  def board_full?
    count = 0
    @board.each do |line|
      line.each do |spot|
        count += 1 if !spot.nil?
      end 
      return true if count == 42
    end 
    false
  end   

  def current_player
    @players[@current_player_id]
  end

  def opponent
    @players[other_player_id]
  end

  def other_player_id
    1 - @current_player_id
  end

  def switch_players!
    @current_player_id = other_player_id
  end

  def print_board
    print "1 2 3 4 5 6 7\n"
    @board.each_with_index do |line, index|
      changed = line.map {|spot| spot.nil? ? "\u{26F6} " : "#{spot} " }.join
      puts "#{changed}"
    end
  end
end