require_relative '../lib/game.rb'
require_relative '../lib/modules.rb'
require_relative '../lib/player.rb'

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
        full_board.board = [[nil, nil],[nil,nil],[nil, 'o']]
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

  describe '#win_vertically?' do
    subject(:vertical_game) { described_class.new }
      
    context 'when player has 4 pieces in a column' do
      it 'returns true' do
        vertical_game.board = [[nil, 'x', nil, nil, nil, nil, nil], 
        ['x', 'x', 'x', 'x', nil, nil, 't'], 
        [nil, 'x', nil, 'x', nil, nil, nil], 
        [nil, 'x', nil, nil, nil, nil, nil]]
        players = vertical_game.instance_variable_get(:@players)
        expect(vertical_game.win_vertically?(players[0])).to eq(true)
      end
    end    

    context 'when player does not have 4 pieces in a column' do
      it 'returns false' do
        vertical_game.board = [[nil, nil, 'x', nil, nil, nil, nil], 
        ['x', nil, 'x', 'x', nil, nil, nil], 
        ['x', nil, '+', nil, nil, nil, nil],
        [nil, nil, 'x', nil, 'x', nil, nil]]
        players = vertical_game.instance_variable_get(:@players)
        expect(vertical_game.win_horizontally?(players[0])).to eq(false)
      end
    end    
  end

  describe '#win_diagonally?' do
    subject(:diagonal_game) { described_class.new }
      
    context 'when player has 4 pieces in a diagonal' do
      it 'returns true' do
        diagonal_game.board = [['x', 'x', nil, nil, nil, nil, nil], 
        ['x', 'x', 'x', 'x', nil, nil, 't'], 
        [nil, 'x', 'x', 'x', nil, nil, nil], 
        [nil, 'x', nil, 'x', nil, nil, nil]]
        players = diagonal_game.instance_variable_get(:@players)
        expect(diagonal_game.win_vertically?(players[0])).to eq(true)
      end
    end    

    context 'when player does not have 4 pieces in a diagonal' do
      it 'returns false' do
        diagonal_game.board = [[nil, nil, 'x', nil, nil, nil, nil], 
        ['x', nil, 'x', 'x', nil, nil, nil], 
        ['x', nil, '+', nil, nil, nil, nil],
        [nil, nil, 'x', nil, 'x', nil, nil]]
        players = diagonal_game.instance_variable_get(:@players)
        expect(diagonal_game.win_horizontally?(players[0])).to eq(false)
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

  describe '#let_gravity_place_it' do
    subject(:gravity) { described_class.new }

    context 'when player makes a legal column selection' do 
      
      before do
        players = gravity.instance_variable_get(:@players)
        allow(players[0]).to receive(:gets).and_return(6)
      end 

      it 'places player piece in row above bottom piece in column' do
        board = gravity.instance_variable_get(:@board)
        players = gravity.instance_variable_get(:@players)
        expect{ gravity.let_gravity_place_it(players[0]) }.to change { board }
        gravity.let_gravity_place_it(players[0])
      end 
    end  
  end  
end 
