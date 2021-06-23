require 'rails_helper'
require 'json'

feature 'Get quote', '
  Any user get current stock quotes
  on app page
' do
  given(:stock_json) { File.read("#{Rails.root}/spec/data/stock.json") }
  before { allow(Stock::FetchData).to receive(:call).and_return(stock_json) }

  context 'Existing ticker' do
    scenario 'enough cash' do
      visit get_quote_stocks_path
      fill_in 'Ticker', with: 'AAPL'
      click_on 'Get quote'
      expect(page).to have_content('125.28')
    end
    scenario 'not enough cash'
  end
  scenario 'unknown ticker'
end
