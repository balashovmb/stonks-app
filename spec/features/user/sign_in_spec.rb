require 'rails_helper'

feature 'User sign in', %q{
  In order to be able to buy stocks
  As an user
  I want to be able to sign in
} do
  given(:user) { create(:user) }

  scenario 'Registred user try to sign in' do
    sign_in(user)

    expect(page).to have_content 'Signed in successfully.'
    expect(page).to have_current_path root_path, ignore_query: true
  end

  scenario 'Non-registred user try to sign in' do
    visit new_user_session_path
    fill_in 'Email', with: 'wrong@test.com'
    fill_in 'Password', with: '12345678'
    click_on 'Log in'

    expect(page).to have_content 'Invalid Email or password.'
    expect(page).to have_current_path new_user_session_path, ignore_query: true
  end
end
