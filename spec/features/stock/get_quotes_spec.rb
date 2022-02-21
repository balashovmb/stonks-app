require 'rails_helper'
require 'json'

feature 'Get quote', '
  Any user gets the current stock quotes
  on the app page
' do
  include_context 'stub_api'
  context 'Existing ticker' do
    scenario 'gets quote' do
      visit trading_stocks_path
      fill_in 'Ticker', with: 'AAPL'
      click_on 'Get quote'
      expect(page).to have_content('124.61')
    end
  end

  context 'Unknown ticker' do
    scenario 'shows "unknown ticker" message' do
      visit trading_stocks_path
      fill_in 'Ticker', with: 'ASDFFF'
      click_on 'Get quote'
      expect(page).to have_content('Ticker not found')
    end
  end

  context 'Non-latin chars in ticker' do
    scenario 'shows "Ticker must consist of Latin characters" message' do
      visit trading_stocks_path
      fill_in 'Ticker', with: 'ЯНДЕКС'
      click_on 'Get quote'
      expect(page).to have_content('Ticker must consist of Latin characters')
    end
  end

  context 'Empty ticker' do
    scenario 'shows "Ticker field is empty" message' do
      visit trading_stocks_path
      fill_in 'Ticker', with: ''
      click_on 'Get quote'
      expect(page).to have_content('Ticker field is empty')
    end
  end
end
