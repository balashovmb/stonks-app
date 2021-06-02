require 'rails_helper'
require 'json'

feature 'Create deal', '
  User can make a deal on stock page
' do
  given(:stock_json) { File.read("#{Rails.root}/spec/data/stock.json") }
  before { allow(Stocks::FetchData).to receive(:call).and_return(stock_json) }

  scenario 'Existing ticker', js: true do
    visit "/stocks/get_quote?ticker=aapl"
    fill_in 'Volume', with: '2'
    choose 'deal_direction_long'
    click_on 'Make a deal'
    expect(page).to have_content('direction: long, volume: 2, amount: 249.22 $')
  end
end
