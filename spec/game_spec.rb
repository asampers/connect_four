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

end 
