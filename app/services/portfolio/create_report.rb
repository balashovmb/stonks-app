class Portfolio::CreateReport < Service
  def initialize(portfolio)
    @portfolio = portfolio
  end

  def call
    report = { cash: @portfolio.cash, value: @portfolio.cash }
    tickers = @portfolio.trade_positions.all.map { |position| position.stock.ticker }.sort.join(',')
    return report if tickers.empty?

    stocks = Stock::Get.call(tickers)
    stocks = stocks['quotes']['quote']
    return report unless stocks

    report[:trade_positions_dynamics] = trade_positions_dynamics(@portfolio.trade_positions, stocks)
    report[:financial_result] = financial_result(report)
    report[:value] = (@portfolio.cash + financial_result(report)).to_i
    report
  end

  private

  def financial_result(report)
    report[:trade_positions_dynamics].inject(0) { |sum, stock| sum + stock[:financial_result] }
  end

  def trade_positions_dynamics(trade_positions, stocks)
    stocks.map do |stock|
      current_position = trade_positions.includes(:stock).find_by(stock: { ticker: stock['symbol'] })
      generate_position_props(current_position, stock)
    end
  end

  def generate_position_props(current_position, stock)
    average_price = current_position.average_price
    current_price = stock['last'] * 100
    financial_result = (current_price - average_price) * current_position.volume
    financial_result = -financial_result if current_position.direction == 'short'
    {
      ticker: stock['symbol'],
      direction: current_position.direction,
      volume: current_position.volume,
      amount: current_position.amount,
      average_price: average_price,
      current_price: current_price.to_i,
      financial_result: financial_result.to_i,
      result_in_percent: percent(current_position.amount, financial_result).round(2)
    }
  end

  def percent(full, part)
    part / full.to_f * 100
  end
end
