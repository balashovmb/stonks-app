module ApplicationHelper
  def money_format(number)
    "#{number / 100.0} $"
  end
end
