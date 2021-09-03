require 'rails_helper'

feature 'Deals list', '
  User can see list of all his deals
' do
  context 'deals exists' do
    given(:portfolio) { create(:portfolio) }
    given!(:deal) { create(:deal, portfolio: portfolio) }
    scenario 'shows list' do
      sign_in(portfolio.user)
      visit '/deals'
      expect(page).to have_content('long9991999')
    end
  end

  context 'deals not exists' do
    given(:portfolio) { create(:portfolio) }
    scenario 'shows list' do
      sign_in(portfolio.user)
      visit '/deals'
      expect(page).to have_content("You haven't made a single deal yet")
    end
  end
end
