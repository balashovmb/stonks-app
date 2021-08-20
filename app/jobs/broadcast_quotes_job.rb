class BroadcastQuotesJob < ApplicationJob
  queue_as :default

  def perform(*args)
    SubscribedQuote::RemoveSubscribtionOrBroadcast.call
  end
end
