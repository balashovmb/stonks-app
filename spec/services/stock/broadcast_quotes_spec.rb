require 'rails_helper'

describe Stock::BroadcastQuotes do
  include ActionCable::TestHelper
  include_context 'stub_api'
  let(:subject) { described_class.call('AAPL') }

  it 'broadcasts quote' do
    expect { subject }.to have_broadcasted_to('quotes_AAPL').with(
      "\u003cturbo-stream action=\"update\" target=\"AAPL_price\"\u003e\u003ctemplate\u003e\u003cp data-controller=\"price\" data-price-ticker-value=\"AAPL\"\u003eCurrent price: 124.61 $\u003c/p\u003e\u003c/template\u003e\u003c/turbo-stream\u003e"
    )
  end
end
