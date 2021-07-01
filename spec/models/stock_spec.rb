require 'rails_helper'

RSpec.describe Stock, type: :model do
  it { should validate_presence_of(:ticker) }

  describe '.get_and_create_stock' do
    let(:stock_json) { File.read("#{Rails.root}/spec/data/stock.json") }
    it 'creates stock' do
      allow(Stock::FetchData).to receive(:call).and_return({ stock_json: stock_json, status: 200, source: 'tradier' })
      expect { Stock.get_and_create_stock('AAPL') }.to change { Stock.count }.by(1)
    end
  end

  describe '.get_stock_data' do
    it 'calls get quote service' do
      expect(Stock::Get).to receive(:call).with('AAPL')
      Stock.get_stock_data('AAPL')
    end
  end
end
