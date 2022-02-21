require 'rails_helper'
require 'json'

feature 'Broadcast quotes', '
  The user can see the updated quotes without an update request
' do
  context 'Existing ticker' do
    include_context 'stub_api'
    given(:stock_json) { File.read(Rails.root.join('spec/data/stock.json')) }
    given(:stock_new_quote) { File.read(Rails.root.join('spec/data/stock_new_quote.json')) }
    before { class_double("Stock::FetchData").as_stubbed_const }

    scenario 'updates quote', js: true do
      allow(Stock::FetchData).to receive(:call).and_return({ stock_json: stock_json,
                                                             status: 200,
                                                             source: 'tradier' })
      visit trading_stocks_path
      fill_in 'Ticker', with: 'AAPL'
      click_on 'Get quote'
      expect(page).to have_content('124.61')
      allow(Stock::FetchData).to receive(:call).and_return({ stock_json: stock_new_quote,
                                                             status: 200,
                                                             source: 'tradier' })
      BroadcastQuotesJob.perform_now
      expect(page).to have_content('124.71')
    end
  end
end
