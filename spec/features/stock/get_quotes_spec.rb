require 'rails_helper'
require 'json'

feature 'Get quote', '
  Any user get current stock quotes
  on app page
' do
  context 'Existing ticker' do
    given(:stock_json) { File.read("#{Rails.root}/spec/data/stock.json") }
    before do
      allow(Stock::FetchData).to receive(:call).and_return({ stock_json: stock_json, status: 200, source: 'tradier' })
    end

    scenario 'gets quote' do
      visit get_quote_stocks_path
      fill_in 'Ticker', with: 'AAPL'
      click_on 'Get quote'
      expect(page).to have_content('124.61')
    end
  end
  context 'Unknown ticker' do
    given(:unknown_ticker_json) { File.read("#{Rails.root}/spec/data/unknown_ticker.json") }
    before do
      allow(Stock::FetchData).to receive(:call).and_return({ stock_json: unknown_ticker_json, status: 200, source: 'tradier' })
    end
    scenario 'shows "unknown ticker" message' do
      visit get_quote_stocks_path
      fill_in 'Ticker', with: 'ASDFFF'
      click_on 'Get quote'
      expect(page).to have_content('Ticker not found')
    end
  end
  context 'Non-latin chars in ticker' do
    scenario 'shows "Ticker must consist of Latin characters" message' do
      visit get_quote_stocks_path
      fill_in 'Ticker', with: 'ЯНДЕКС'
      click_on 'Get quote'
      expect(page).to have_content('Ticker must consist of Latin characters')
    end
  end
  context 'Empty ticker' do
    scenario 'shows "Ticker field is empty" message' do
      visit get_quote_stocks_path
      fill_in 'Ticker', with: ''
      click_on 'Get quote'
      expect(page).to have_content('Ticker field is empty')
    end
  end
end
