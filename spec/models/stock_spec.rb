require 'rails_helper'

RSpec.describe Stock, type: :model do
  it { should validate_presence_of(:ticker) }

  describe '.get_quote' do
    it 'calls get quote service' do
      expect(Stocks::Get).to receive(:call).with('AAPL')
      Stock.get_quote('AAPL')
    end
  end
end
