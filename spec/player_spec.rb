require_relative '../main.rb'

describe Player do
  describe '#select_column' do
    subject(:player) {described_class.new(game, 'x', 'Chrissy')}
    let(:game) {instance_double(Game)}
    
    context 'when column is not full' do
      before do
        valid_column = 3
        allow(player).to receive(:gets).and_return(valid_column)
        allow(game).to receive(:print_board)
        allow(game).to receive(:row_full?).with(valid_column).and_return(false)
      end 

      it 'stops loop and does not display error message' do
        valid_column = '3'
        error_message = "Column #{valid_column} is already full. Try again."
        expect(player).not_to receive(:puts).with(error_message)
        player.select_column
      end 
    end   

    context 'when column is full' do
      before do
        full_column = 3
        empty_column = 2
        allow(player).to receive(:gets).and_return(full_column, empty_column)
        allow(game).to receive(:print_board)
        allow(game).to receive(:row_full?).with(full_column).and_return(true)
        allow(game).to receive(:row_full?).with(empty_column).and_return(false)
      end 

      it 'displays error message once' do
        full_column = 3
        empty_column = 2
        error_message = "Column #{full_column} is already full. Try again."
        expect(player).to receive(:puts).twice 
        player.select_column
      end 
    end     
  end


end