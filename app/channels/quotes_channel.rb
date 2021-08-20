class QuotesChannel < ApplicationCable::Channel
  def subscribed_quotes(data)
    stop_all_streams
    ticker = data['ticker']
    channel_name = "quotes_#{ticker}"
    stream_from channel_name
    sq = SubscribedQuote.where(ticker: ticker).first_or_create
    sq.touch
  end

  def unsubscribed_quotes
    stop_all_streams
    # Any cleanup needed when channel is unsubscribed
  end

  def quotes_received(data)
    SubscribedQuote.find_by(ticker: data['ticker'])&.touch
  end
end
