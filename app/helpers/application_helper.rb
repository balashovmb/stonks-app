module ApplicationHelper
  def money_format(number, options = {})
    without_currency_sign = options[:without_currency_sign]
    number ||= 0
    "#{number / 100.0}#{without_currency_sign ? '' : ' $'}"
  end
end
