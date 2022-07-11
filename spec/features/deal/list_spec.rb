require 'rails_helper'

feature 'Deals list', '
  The user can see a list of all his deals
' do
  include_context 'stub_api'
  given(:portfolio) { create(:portfolio) }

  before do
    sign_in(portfolio.user)
  end

  context 'deals not exists' do
    scenario 'shows list' do
      visit deals_path
      expect(page).to have_content("You haven't made a single deal yet")
    end
  end

  context 'over 20 deals' do
    given(:stock) { create(:stock, ticker: "AZZ") }
    given(:stock2) { create(:stock, ticker: "AAPL") }
    given!(:deal) { create(:deal, portfolio:, stock: stock, volume: 2) }
    given!(:deals_list) { create_list(:deal, 20, portfolio:, stock: stock2) }

    scenario 'shows first page of deals' do
      visit deals_path

      expect(page).to have_content('long9.9919.99AAPL')
      expect(page).not_to have_content("AZZ")
    end

    scenario 'shows last page of deals' do
      visit deals_path(page: 2)
      expect(page).to have_content("long9.99219.98")
      expect(page).to have_content("AZZ")
    end
  end
end
