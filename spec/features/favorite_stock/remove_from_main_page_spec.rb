require 'rails_helper'

feature 'A registered user
can remove a stock from favorites from the popular stocks page
for ease of trading' do
  given(:user) { create(:user) }
  given(:stock) { create(:stock) }
  given!(:favorite_stock) { create(:favorite_stock, stock: stock, user: user) }
  scenario 'adds stock to favorites', js: true do
    sign_in(user)
    visit '/stocks'
    click_on('Remove from favorites')

    expect(page).to have_button('Add to favorites')
  end
end
