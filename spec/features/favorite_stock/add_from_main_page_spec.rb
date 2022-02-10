require 'rails_helper'

feature 'A registered user
can add a stock to favorites from the popular stocks page
for ease of trading' do
  given(:user) { create(:user) }
  given!(:stock) { create(:stock) }
  scenario 'adds stock to favorites', js: true do
    sign_in(user)
    visit '/stocks'
    click_on('Add to favorites')

    expect(page).to have_button('Remove from favorites')
  end
end
