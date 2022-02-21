require 'rails_helper'

feature 'Show daily quotes', 'Any user
can see daily quotes of last week on trading page' do
  include_context 'stub_api'
  given(:stock) { create(:stock) }
  given!(:daily_quotes) { create_list(:daily_quote, 5, stock: stock) }

  scenario 'shows quotes' do
    visit trading_stocks_path(ticker: stock.ticker)

    expect(page).to have_content(Time.zone.today - 1)
    expect(page).to have_content(101)
  end
end
