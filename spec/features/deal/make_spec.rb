require 'rails_helper'
require 'json'

feature 'Make a deal', '
  A logged-in user can make a deal on the stock page
' do
  include_context 'stub_api'
  given(:portfolio) { create(:portfolio) }
  given(:stock) { create(:stock) }

  context 'Logged in user' do

    before do
      sign_in(portfolio.user)
      visit '/stocks/trading?ticker=AAPL'
    end

    context 'enough cash' do
      scenario 'creates deal', js: true do
        fill_in 'Volume', with: '2'
        choose 'deal_direction_long'
        click_on 'Make a deal'
        expect(page).to have_content('direction: long, volume: 2, amount: 249.22 $')
        expect(page).to have_content('Cash: 9750.78 $')
      end
    end

    context 'not enough cash' do
      scenario 'don\'t creates deal', js: true do
        fill_in 'Volume', with: '10000'
        choose 'deal_direction_long'
        click_on 'Make a deal'
        expect(page).to have_content('Not enough cash')
        expect(page).not_to have_content('direction: long, volume: 10000,')
      end
    end

    context 'direction is not selected' do
      scenario 'don\'t creates deal', js: true do
        fill_in 'Volume', with: '2'
        click_on 'Make a deal'
        expect(page).to have_content('Please select direction')
        expect(page).not_to have_content(', volume: 2,')
      end
    end
    context 'volume is not selected' do
      scenario 'don\'t creates deal', js: true do
        choose 'deal_direction_long'
        click_on 'Make a deal'
        expect(page).to have_content('Please enter the number of stocks')
        expect(page).not_to have_content('direction: long,')
      end
    end
  end

  context 'Non logged in user' do
    before do
      visit '/stocks/trading?ticker=AAPL'
    end

    scenario 'don\'t see Deal button', js: true do
      expect(page).not_to have_button('Make a deal')
    end
  end
end
