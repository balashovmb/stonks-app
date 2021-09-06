require 'rails_helper'
require 'json'

feature 'Portfolio report', '
  User can see portfolio report on portfolio page
' do
  context 'Logged in user' do
    given(:stock_json) { File.read(Rails.root.join('spec/data/stock.json')) }
    given(:portfolio) { create(:portfolio) }
    given!(:deal) { create(:deal, portfolio: portfolio) }
    before do
      allow(Stock::FetchData).to receive(:call).and_return({ stock_json: stock_json,
                                                             status: 200,
                                                             source: 'tradier' })
    end

    scenario 'one stock' do
      sign_in(portfolio.user)
      click_on 'Portfolio'

      expect(page).to have_content('Portfolio value: 10104.63 $')
      expect(page).to have_content('Financial result: 114.62 $')
    end
  end

  context 'Non logged in user' do
    scenario 'can\'t see Portfolio link ' do
      expect(page).not_to have_link('Portfolio')
    end
  end
end
