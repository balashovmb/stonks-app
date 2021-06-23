module ApplicationHelper
  def money_format(number)
    number ||= 0
    "#{number / 100.0} $"
  end
end
