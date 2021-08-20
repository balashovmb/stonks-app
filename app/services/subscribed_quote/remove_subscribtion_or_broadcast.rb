class SubscribedQuote::RemoveSubscribtionOrBroadcast < Service
  def call
    SubscribedQuote.find_each do |sq|
      if sq.updated_at + 2.minutes < Time.zone.now
        sq.destroy
      else
        Stock::BroadcastQuotes.call(sq.ticker)
      end
    end
  end
end
