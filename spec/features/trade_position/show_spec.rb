require 'rails_helper'

feature 'Show trade position', '
  User can see trade position on portfolio page
' do
  given(:portfolio) { create(:portfolio) }
  context 'one deal' do
    include_context 'stub_api'

    given!(:deal) { create(:deal, portfolio: portfolio) }
    scenario 'long position' do
      sign_in(portfolio.user)
      click_on 'Portfolio'

      expect(page).to have_content('AAPLlong19.99 $124.61 $124.61 $114.62 $1147.35')
    end
  end
end
