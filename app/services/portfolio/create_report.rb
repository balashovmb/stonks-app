class Portfolio::CreateReport < Service
  def initialize(portfolio)
    @portfolio = portfolio
  end

  def call
    report = { cash: portfolio.cash, value: portfolio.cash }
    tickers = portfolio.trade_positions.includes(:stock).all.map do |position|
      position.stock.ticker
    end.sort.join(',')
    return report if tickers.empty?

    stocks_with_metadata = Stock::Get.call(tickers)
    stocks = stocks_with_metadata.success? ? stocks_with_metadata.success[:stocks] : nil
    return report unless stocks

    report[:trade_positions_dynamics] = trade_positions_dynamics(portfolio.trade_positions, stocks)
    dynamic_props_of_positions = dynamic_props_of_positions(report[:trade_positions_dynamics])
    current_amount_of_stocks = dynamic_props_of_positions[:current_amount]
    report[:financial_result] = dynamic_props_of_positions[:financial_result]
    report[:value] = portfolio.cash + current_amount_of_stocks
    report
  end

  private

  attr_reader :portfolio

  def dynamic_props_of_positions(trade_positions_dynamics)
    trade_positions_dynamics.each_with_object({ current_amount: 0,
                                                financial_result: 0 }) do |position, res|
      res[:current_amount] += position[:current_price] * position[:volume]
      res[:financial_result] += position[:financial_result]
    end
  end

  def trade_positions_dynamics(trade_positions, stocks)
    stocks.keys.map do |ticker|
      current_position = trade_positions.includes(:stock)
                                        .find_by(stock: { ticker: ticker.to_s.upcase })
      generate_position_props(current_position, stocks[ticker])
    end
  end

  def generate_position_props(current_position, stock)
    average_price = current_position.average_price
    current_price = stock[:current_price].to_i
    financial_result = (current_price - average_price) * current_position.volume
    financial_result *= -1 if current_position.direction == 'short'
    {
      ticker: stock[:ticker],
      direction: current_position.direction,
      volume: current_position.volume,
      amount: current_position.amount,
      current_amount: current_price * current_position.volume,
      average_price: average_price,
      current_price: current_price,
      financial_result: financial_result.to_i,
      result_in_percent: percent(current_position.amount, financial_result)
    }
  end

  def percent(full, part)
    (part / full.to_f * 100).round(2)
  end
end
