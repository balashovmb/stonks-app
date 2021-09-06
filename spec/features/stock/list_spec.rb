require 'rails_helper'

feature 'Stocks list', '
  Any user can see the list of popular stocks
' do
  given!(:quote) { create(:stock, ticker: 'AAPL') }
  given!(:quote2) { create(:stock, ticker: 'AZZ') }
  given(:stocks_list_json) { File.read(Rails.root.join('spec/data/stocks_list.json')) }
  before do
    allow(Stock::FetchData).to receive(:call).and_return({ stock_json: stocks_list_json,
                                                           status: 200,
                                                           source: 'tradier' })
  end

  scenario 'shows list of stocks' do
    visit stocks_path
    expect(page).to have_content 'AAPL'
    expect(page).to have_content 'AZZ'
    expect(page).to have_content '124.61'
    expect(page).to have_content '53.49'
  end
end
