class Game

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
        puts "#{current_player} wins!"
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

  def move_vertically(board, index, ind)
    return if board[index+3].nil?
    [board[index][ind], board[index+1][ind], board[index+2][ind], board[index+3][ind]]
  end

  def move_down_diagonally(board, index, ind)
    return if board[index+3].nil?
    [board[index][ind], board[index+1][ind+1], board[index+2][ind+2], board[index+3][ind+3]]
  end

  def move_up_diagonally(board, index, ind)
    return if board[index-3].nil?
    [board[index][ind], board[index-1][ind+1], board[index-2][ind+2], board[index-3][ind+3]]
  end

  def four_in_row(player)
    piece = player.piece
    combo = ["#{piece}", "#{piece}", "#{piece}", "#{piece}"]
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
    print "  1 2 3 4 5 6 7\n"
    @board.each_with_index do |line, index|
      changed = line.map {|spot| spot.nil? ? "\u{26F6} " : "#{spot} " }.join
      puts "#{index+1} #{changed}"
    end
  end
end


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

#game = Game.new
Game.new.play
#p game.win_horizontally?(game.current_player)
#game.print_board
#game.let_gravity_place_it(game.current_player)
#game.print_board

#game.print_board
#p game.current_player.piece