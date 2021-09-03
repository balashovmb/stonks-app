class BroadcastQuotesJob < ApplicationJob
  queue_as :default

  def perform(*_args)
    SubscribedQuote::RemoveSubscribtionOrBroadcast.call
  end
end
