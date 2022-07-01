class SubscribedQuote::Create < Service
  def initialize(ticker)
    @ticker = ticker
  end

  def call
    sq = SubscribedQuote.where(ticker:).first_or_create
    sq.touch
  end

  private

  attr_reader :ticker
end
