require 'rails_helper'

feature 'Show trade position', '
  User can see trade position on portfolio page
' do
  given(:portfolio) { create(:portfolio) }
  context 'one deal' do
    given(:stock_json) { File.read(Rails.root.join('spec/data/stock.json')) }
    before do
      allow(Stock::FetchData).to receive(:call).and_return({ stock_json: stock_json,
                                                             status: 200,
                                                             source: 'tradier' })
    end

    given!(:deal) { create(:deal, portfolio: portfolio) }
    scenario 'long position' do
      sign_in(portfolio.user)
      click_on 'Portfolio'

      expect(page).to have_content('AAPLlong19.99 $9.99 $124.61 $114.62 $1147.35')
    end
  end
end
