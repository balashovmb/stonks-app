require 'rails_helper'

feature 'Show trade position', '
  User can see trade position on portfolio page
' do
  given(:portfolio) { create(:portfolio) }
  context 'one deal' do
    given!(:deal) { create(:deal, portfolio: portfolio) }
    scenario 'long position' do
      sign_in(portfolio.user)
      click_on 'Portfolio'

      expect(page).to have_content('AAPL')
    end
  end
end
