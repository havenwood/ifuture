require_relative 'helper.rb'

describe IFuture do
  before do
    @future = IFuture.new { sleep 0.25; 'peppermint' }
  end
  
  describe 'before the value is ready' do
    describe 'when asked if ready?' do
      it 'will respond false' do
        refute @future.ready?
      end
    end
    
    describe 'when asked for value' do
      it 'will block then return value' do
        assert_equal @future.value, "peppermint"
      end
    end
  end
  
  describe 'after the value is ready' do
    before do
      sleep 0.5
    end
    
    describe 'when asked if ready?' do
      it 'will respond true' do
        assert @future.ready?
      end
    end
    
    describe 'when asked for value' do
      it 'will return value' do
        assert_equal @future.value, "peppermint"
      end
    end
  end
end