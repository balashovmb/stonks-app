require 'rails_helper'
require 'json'

feature 'Get quote', '
  Any user see recent stock quotes
  on app page
' do
  context 'Existing ticker' do
    given(:stock_json) { File.read(Rails.root.join('spec/data/stock.json')) }
    given(:stock_new_quote) { File.read(Rails.root.join('spec/data/stock_new_quote.json')) }

    scenario 'updates quote', js: true do
      allow(Stock::FetchData).to receive(:call).and_return({ stock_json: stock_json,
                                                             status: 200,
                                                             source: 'tradier' })
      visit get_quote_stocks_path
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
