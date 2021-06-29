require 'rails_helper'

describe Portfolio::CreateReport do
  let(:stock_json) { File.read("#{Rails.root}/spec/data/stock.json") }

  let(:portfolio) { create(:portfolio) }
  let!(:deal) { create(:deal, portfolio: portfolio) }
  let(:subject) { described_class.call(portfolio) }
  before { allow(Stock::FetchData).to receive(:call).and_return(stock_json) }
  it 'creates TradePosition' do
    expect(subject).to eq(
      {
        cash: 999001,
        trade_positions_dynamics: [
          {amount: 999, average_price: 999, current_price: 12461, direction: "long", financial_result: 11462, ticker: "AAPL", volume: 1, result_in_percent: 1147.35,}
        ],
        value: 1010463,
        financial_result: 11462
      }
    )
  end
end
