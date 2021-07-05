require 'rails_helper'

feature 'Change cash wolume', '
  A registered user can add cash to the portfolio and withdraw it
' do
  given(:user) { create(:user) }

  scenario 'user adds cash' do
    sign_in(user)
    click_on 'Portfolio'
    fill_in 'Summ', with: '1000'
    choose 'operation_deposite'
    click_on 'Make operation'
    expect(page).to have_content('You added 1000.0 $')
  end

  context 'withdraw' do
    scenario 'user withdraws cash' do
      user.portfolio.update(cash: 100000)

      sign_in(user)
      click_on 'Portfolio'
      fill_in 'Summ', with: '1000'
      choose 'operation_widthdraw'
      click_on 'Make operation'
      expect(page).to have_content('You have withdrawn 1000.0 $')
    end

    scenario 'user don\'t have enough cash' do
      sign_in(user)
      click_on 'Portfolio'
      fill_in 'Summ', with: '1000'
      choose 'operation_widthdraw'
      click_on 'Make operation'
      expect(page).to have_content("You don't have that much cash")
    end
  end
end
