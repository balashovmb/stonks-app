require 'rails_helper'

feature 'A registered user
can add a stock to favorites
for ease of trading' do
  include_context 'stub_api'
  given(:user) { create(:user) }
  given!(:stock) { create(:stock) }
  context 'from the popular stocks page' do
    scenario 'signed in user adds stock to favorites', js: true do
      sign_in(user)
      visit '/stocks'
      click_on('Add to favorites')

      expect(page).to have_button('Remove from favorites')
    end

    scenario 'non signed in user don\'t see Add to favorites button' do
      visit '/stocks'
      expect(page).not_to have_button('Remove from favorites')
    end
  end
end
