require 'rails_helper'

feature 'Quotes list', '
  Any user can see list of popular quotes
' do
  given!(:quote) { create(:stock, ticker: "AAPL") }
  given!(:quote2) { create(:stock, ticker: "AZZ") }
  let(:stocks_list_json) { File.read("#{Rails.root}/spec/data/stocks_list.json") }
  before { allow(Stocks::FetchData).to receive(:call).and_return(stocks_list_json) }

  scenario 'shows list of stocks' do
    visit stocks_path
    expect(page).to have_content 'AAPL'
    expect(page).to have_content 'AZZ'
    expect(page).to have_content '124.61'
    expect(page).to have_content '53.49'
  end
end
