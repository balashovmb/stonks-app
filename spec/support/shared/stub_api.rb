shared_context "stub_api", :stub_api do
  before do
    stub_request(:get, "https://sandbox.tradier.com/v1/markets/quotes?symbols=AAPL")
      .to_return(status: 200, body: File.read(Rails.root.join('spec/data/stock.json')), headers: {})
    stub_request(:get, "https://sandbox.tradier.com/v1/markets/history?end=2022-02-17&interval=daily&start=2022-01-18&symbol=AAPL")
      .to_return(status: 200, body: File.read(Rails.root.join('spec/data/daily_quotes.json')), headers: {})
    stub_request(:get, "https://sandbox.tradier.com/v1/markets/quotes?symbols=ASDFFF")
      .to_return(status: 200, body: File.read(Rails.root.join('spec/data/unknown_ticker.json')), headers: {})
  end
end
