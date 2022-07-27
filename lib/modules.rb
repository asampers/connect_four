module GetNames
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
end

module PlacingPieces

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
end