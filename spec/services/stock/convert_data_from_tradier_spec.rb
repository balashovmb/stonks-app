require 'rails_helper'

describe Stock::ConvertDataFromTradier do
  let(:stock_json) { File.read(Rails.root.join('spec/data/stock.json')) }
  let(:stocks_list) { File.read(Rails.root.join('spec/data/stocks_list.json')) }

  let(:subject) { described_class.call(stock_json: stock_json) }
  let(:subject2) { described_class.call(stock_json: stocks_list) }

  it 'converts one stock data from Tradier' do
    expect(subject).to eq(stocks: { aapl: Stock.first })
  end

  it 'converts stocks list data from Tradier' do
    expect(subject2).to eq(
      stocks: {
        aapl: Stock.first,
        azz: Stock.last
      }
    )
  end
end
