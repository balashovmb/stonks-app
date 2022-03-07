require 'json'

class DailyQuote::CreateFromApiData < Service
  def initialize(data, options)
    @data = data
    @source = data[:source]
    @options = options
  end

  def call
    case @source
    when 'tradier'
      DailyQuote::CreateFromTradierData.call(@data, @options)
    end
  end
end
