require 'rails_helper'
require 'json'

feature 'Show balance', '
  A logged-in user can see balance in footer
' do
  given(:portfolio) { create(:portfolio) }

  scenario 'Logged in user see balance' do
    sign_in(portfolio.user)

    expect(page).to have_content('10000.0 $')
  end
end
