class TradePosition::CreateOrUpdate < Service
  def initialize(deal)
    @deal = deal
  end

  def call
    trade_position = deal.portfolio.trade_positions.find_by(stock_id: deal.stock_id)
    if !trade_position
      TradePosition.create(
        direction: deal.direction,
        stock: deal.stock,
        average_price: deal.price,
        portfolio: deal.portfolio,
        volume: deal.volume
      )
    else
      update_trade_position(trade_position)
    end
  end

  private

  attr_reader :deal

  def update_trade_position(trade_position)
    if deal.direction == trade_position.direction
      trade_position_changed_params = {
        average_price: new_average_price(trade_position, same_direction: true),
        volume: deal.volume + trade_position.volume
      }
    elsif trade_position.volume == deal.volume
      return trade_position.destroy
    elsif trade_position.volume > deal.volume
      trade_position_changed_params = {
        average_price: new_average_price(trade_position),
        volume: trade_position.volume - deal.volume
      }
    elsif trade_position.volume < deal.volume
      trade_position_changed_params = {
        direction: change_direction(trade_position.direction),
        average_price: new_average_price(trade_position),
        volume: deal.volume - trade_position.volume
      }
    end
    trade_position.update(trade_position_changed_params)
  end

  def new_average_price(trade_position, same_direction: false)
    if same_direction
      (trade_position.amount + deal.amount) / (trade_position.volume + deal.volume)
    else
      (trade_position.amount - deal.amount).abs / (trade_position.volume - deal.volume).abs
    end
  end

  def change_direction(direction)
    direction == 'long' ? 0 : 1
  end
end
