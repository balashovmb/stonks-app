require 'rails_helper'

feature 'Portfolio report', '
  User can see portfolio report on portfolio page
' do
  context 'Logged in user' do
    include_context 'stub_api'
    given(:portfolio) { create(:portfolio) }
    given!(:deal) { create(:deal, portfolio: portfolio) }
    scenario 'one stock' do
      sign_in(portfolio.user)
      click_on 'Portfolio'
      expect(page).to have_content('Portfolio value: 10114.62 $')
      expect(page).to have_content('Financial result: 114.62 $')
      expect(page).to have_content('Free cash: 9990.01 $')
    end
  end

  context 'Non logged in user' do
    scenario 'can\'t see Portfolio link ' do
      expect(page).not_to have_link('Portfolio')
    end
  end
end
