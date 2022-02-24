require 'rails_helper'

feature 'Show daily stock chart', 'Any user
can see daily stock chart of last 30 days on trading page' do
  include_context 'stub_api'

  context 'when stock selected' do
    given(:stock) { create(:stock) }
    given!(:daily_quotes) { create_list(:daily_quote, 30, stock: stock) }
    scenario 'shows chart' do
      visit trading_stocks_path(ticker: stock.ticker)

      expect(page).to have_selector(:id, 'stock_chart')
    end
  end

  context 'when stock don\'t selected' do
    scenario 'shows chart' do
      visit trading_stocks_path

      expect(page).not_to have_selector(:id, 'stock_chart')
    end
  end
end
