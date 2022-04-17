require 'rails_helper'

feature 'Show daily quotes', 'Any user
can see daily quotes of last week on trading page' do
  include_context 'stub_api'
  given(:stock) { create(:stock) }

  scenario 'shows quotes' do
    visit trading_stocks_path(ticker: stock.ticker)

    expect(page).to have_css('#stock_chart')
  end
end
