require 'active_support/concern'

module Measureable
  extend ActiveSupport::Concern
  included do
    enum direction: {
      short: 0,
      long: 1
    }
  end

  def amount
    volume * price
  end
end
