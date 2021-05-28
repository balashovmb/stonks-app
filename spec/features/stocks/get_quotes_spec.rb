require 'rails_helper'

feature 'Get quote', '
  Any user get current stock quotes
  on app page
' do
  let(:apple) do
    { 'quotes' =>
      { 'quote' =>
        {
          'symbol' => 'AAPL',
          'description' => 'Apple Inc',
          'exch' => 'Q',
          'type' => 'stock',
          'last' => 125.28,
          'change' => 0.0,
          'volume' => 24_593,
          'open' => nil,
          'high' => nil,
          'low' => nil,
          'close' => nil,
          'bid' => 126.14,
          'ask' => 126.23,
          'change_percentage' => 0.0,
          'average_volume' => 99_227_948,
          'last_volume' => 21_286_006,
          'trade_date' => 1_622_145_601_555,
          'prevclose' => 125.28,
          'week_52_high' => 145.09,
          'week_52_low' => 79.1175,
          'bidsize' => 1,
          'bidexch' => 'Q',
          'bid_date' => 1_622_195_113_000,
          'asksize' => 6,
          'askexch' => 'P',
          'ask_date' => 1_622_194_970_000,
          'root_symbols' => 'AAPL'
        } } }
  end

  before do
    allow(Stock).to receive(:get_quote).with('AAPL').and_return(apple)
  end

  scenario 'Existing ticker' do
    visit get_quote_stocks_path
    fill_in 'Ticker', with: 'AAPL'
    click_on 'Get quote'
    expect(page).to have_content('125.28')
  end
end
