require 'rails_helper'

describe Stock::BroadcastQuotes do
  include ActionCable::TestHelper
  let(:subject) { described_class.call('AAPL') }
  let(:stock_json) { File.read("#{Rails.root}/spec/data/stock.json") }
  before do
    allow(Stock::FetchData).to receive(:call).and_return({ stock_json: stock_json, status: 200, source: 'tradier' })
  end

  it 'broadcasts quote' do
    expect { subject }.to have_broadcasted_to('quotes_AAPL').with(
      {
        'cableReady' => true,
        'operations' => {
          'textContent' =>
            [
              { 'selector' => '#quote', 'text' => 'Current price: 124.61 $', 'ticker' => 'AAPL' }
            ],
          'setValue' =>
            [
              { 'selector' => '#deal_price', 'value' => 124.61, 'ticker' => 'AAPL' }
            ]
        }
      }
    )
  end
end
