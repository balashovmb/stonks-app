require 'rails_helper'

feature 'Change cash volume', '
  A registered user can add cash to the portfolio and withdraw it
' do
  given(:user) { create(:user) }

  context 'user don\'t select operation' do
    scenario 'shows error message' do
      sign_in(user)
      click_on 'Portfolio'
      fill_in 'Sum', with: '1000'
      click_on 'Execute operation'
      expect(page).to have_content('Please select the operation')
    end
  end

  context 'user don\'t input amount' do
    scenario 'shows error message' do
      sign_in(user)
      click_on 'Portfolio'
      choose 'operation_deposite'
      click_on 'Execute operation'
      expect(page).to have_content('Please input positive amount')
    end
  end

  context 'user inputs negative amount' do
    scenario 'shows error message' do
      sign_in(user)
      click_on 'Portfolio'
      choose 'operation_deposite'
      fill_in 'Sum', with: '-1000'
      click_on 'Execute operation'
      expect(page).to have_content('Please input positive amount')
    end
  end

  scenario 'user adds cash' do
    sign_in(user)
    click_on 'Portfolio'
    fill_in 'Sum', with: '1000'
    choose 'operation_deposite'
    click_on 'Execute operation'
    expect(page).to have_content('You have deposited 1000.0 $')
  end

  context 'withdraw' do
    scenario 'user withdraws cash' do
      user.portfolio.update(cash: 100000)

      sign_in(user)
      click_on 'Portfolio'
      fill_in 'Sum', with: '1000'
      choose 'operation_widthdraw'
      click_on 'Execute operation'
      expect(page).to have_content('You have withdrawn 1000.0 $')
    end

    scenario 'user don\'t have enough cash' do
      sign_in(user)
      click_on 'Portfolio'
      fill_in 'Sum', with: '10001'
      choose 'operation_widthdraw'
      click_on 'Execute operation'
      expect(page).to have_content("You don't have enough cash")
    end
  end
end
