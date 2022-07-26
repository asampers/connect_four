require_relative '../main.rb'

describe Game do
  describe '#row_full?' do 
    subject(:full_board) {described_class.new}
    context 'when row is full' do
      it 'returns true' do
        full_board.board = [[nil, 'x'],[nil,'+'],[nil, 'o']]
        selection = 2
        expect(full_board.row_full?(selection)).to eq(true)
      end
    end

    context 'when row has one piece' do
      it 'returns false' do
        full_board.board = [["X", nil],['+',nil],[nil, 'o']]
        selection = 2
        expect(full_board.row_full?(selection)).to eq(false)
      end
    end  
  end      

  describe '#win_horizontally?' do
    subject(:row_game) { described_class.new }
      
    context 'when player has 4 pieces in a row' do
      it 'returns true' do
        row_game.board = [[nil, nil, nil, nil], ['x', 'x', 'x', 'x', nil, nil], [nil, nil, nil, nil]]
        players = row_game.instance_variable_get(:@players)
        expect(row_game.win_horizontally?(players[0])).to eq(true)
      end
    end    

    context 'when player does not have 4 pieces in a row' do
      it 'returns false' do
        row_game.board = [[nil, nil, nil, nil], ['x', nil, 'x', 'x', nil, nil], [nil, nil, nil, nil]]
        players = row_game.instance_variable_get(:@players)
        expect(row_game.win_horizontally?(players[0])).to eq(false)
      end
    end    
  end

  describe '#four_in_row' do
    subject(:game) { described_class.new }

    context 'when given player' do
      it 'returns player one combo' do
        players = game.instance_variable_get(:@players)
        expect(game.four_in_row(players[0])).to eq(["x", "x", "x", "x"])
      end

      it 'returns player two combo' do
        players = game.instance_variable_get(:@players)
        expect(game.four_in_row(players[1])).to eq(["+", "+", "+", "+"])
      end  
    end 
  end      
end 
