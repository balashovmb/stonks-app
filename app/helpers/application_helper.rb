module ApplicationHelper
  include Pagy::Frontend

  def money_format(number, options = {})
    without_currency_sign = options[:without_currency_sign]
    number ||= 0
    "#{number / 100.0}#{without_currency_sign ? '' : ' $'}"
  end

  def css_alternation(number, prop1, prop2)
    number.even? ? prop1 : prop2
  end
end
