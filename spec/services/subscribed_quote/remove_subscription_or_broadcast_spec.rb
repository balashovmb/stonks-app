require 'rails_helper'

describe SubscribedQuote::RemoveSubscribtionOrBroadcast do
  let(:subject) { described_class.call }

  context 'outdated subscription' do
    let!(:subscribed_quote) { create(:subscribed_quote, ticker: 'AAPL', updated_at: Time.zone.now - 5.minutes) }
    it 'removes subscription' do
      expect { subject }.to change { SubscribedQuote.count }.by(-1)
    end
  end
  context 'actual subscription' do
    let!(:subscribed_quote) { create(:subscribed_quote, ticker: 'AAPL') }
    it 'calls BroadcastQuotes service' do
      expect(Stock::BroadcastQuotes).to receive(:call).with('AAPL')
      subject
    end
  end
end
