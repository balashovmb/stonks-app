require 'rails_helper'

describe Stock::GetDataAndCreate do

  context 'existed stock' do
    let(:stock_json) { File.read(Rails.root.join('spec/data/stock.json')) }

    it 'creates stock' do
      allow(Stock::FetchData).to receive(:call).and_return({ stock_json: stock_json, status: 200,
                                                             source: 'tradier' })
      expect { Stock::GetDataAndCreate.call('AAPL') }.to change(Stock, :count).by(1)
    end
  end

  context 'unknown ticker' do
    let(:stock_json) { '{"quotes":{"unmatched_symbols":{"symbol":"WRONGSYMBOL"}}}' }

    it 'don\'t creates stock' do
      allow(Stock::FetchData).to receive(:call).and_return({ stock_json: stock_json, status: 200,
                                                             source: 'tradier' })
      expect { Stock::GetDataAndCreate.call('WRONGSYMBOL') }.not_to change(Stock, :count)
    end
  end
  context 'cyrillic ticker' do
    let(:stock_json) { '{"quotes":{"unmatched_symbols":{"symbol":"ЯНДЕКС"}}}' }

    it 'don\'t creates stock' do
      allow(Stock::FetchData).to receive(:call).and_return({ stock_json: stock_json, status: 200,
                                                             source: 'tradier' })
      expect { Stock::GetDataAndCreate.call('ЯНДЕКС') }.not_to change(Stock, :count)
    end
  end
end