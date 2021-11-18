require 'rails_helper'

RSpec.describe Stock, type: :model do
  it { is_expected.to validate_presence_of(:ticker) }

  describe '.get_and_create_stock' do
    context 'existed stock' do
      let(:stock_json) { File.read(Rails.root.join('spec/data/stock.json')) }

      it 'creates stock' do
        allow(Stock::FetchData).to receive(:call).and_return({ stock_json: stock_json, status: 200,
                                                               source: 'tradier' })
        expect { Stock.get_and_create_stock('AAPL') }.to change(Stock, :count).by(1)
      end
    end

    context 'unknown ticker' do
      let(:stock_json) { '{"quotes":{"unmatched_symbols":{"symbol":"WRONGSYMBOL"}}}' }

      it 'don\'t creates stock' do
        allow(Stock::FetchData).to receive(:call).and_return({ stock_json: stock_json, status: 200,
                                                               source: 'tradier' })
        expect { Stock.get_and_create_stock('WRONGSYMBOL') }.not_to change(Stock, :count)
      end
    end
    context 'cyrillic ticker' do
      let(:stock_json) { '{"quotes":{"unmatched_symbols":{"symbol":"ЯНДЕКС"}}}' }

      it 'don\'t creates stock' do
        allow(Stock::FetchData).to receive(:call).and_return({ stock_json: stock_json, status: 200,
                                                               source: 'tradier' })
        expect { Stock.get_and_create_stock('ЯНДЕКС') }.not_to change(Stock, :count)
      end
    end
  end

  describe '.get_stock_data' do
    it 'calls get quote service' do
      expect(Stock::Get).to receive(:call).with('AAPL')
      Stock.get_stock_data('AAPL')
    end
  end
end
