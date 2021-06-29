require 'rails_helper'
require 'json'

feature 'Get quote', '
  Any user get current stock quotes
  on app page
' do
  given(:stock_json) { File.read("#{Rails.root}/spec/data/stock.json") }
  before do
    allow(Stock::FetchData).to receive(:call).and_return({ stock_json: stock_json, status: 200, source: 'tradier' })
  end

  scenario 'Existing ticker' do
    visit get_quote_stocks_path
    fill_in 'Ticker', with: 'AAPL'
    click_on 'Get quote'
    expect(page).to have_content('124.61')
  end
  scenario 'unknown ticker'
end
