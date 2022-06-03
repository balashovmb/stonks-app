require 'rails_helper'

describe Stock::BroadcastQuotes do
  include ActionCable::TestHelper
  include_context 'stub_api'
  let(:subject) { described_class.call('AAPL') }

  it 'broadcasts quote' do
    expect { subject }.to have_broadcasted_to('quotes_AAPL').with(
      { "cableReady": true,
        "operations": [
          { "selector": "#quote",
            "text": "Current price: 124.61 $",
            "ticker": "AAPL",
            "operation": "textContent" }
        ],
        "version": "5.0.0.pre9" }
    )
  end
end
