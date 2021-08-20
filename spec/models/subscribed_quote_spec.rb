require 'rails_helper'

RSpec.describe SubscribedQuote, type: :model do
  it { should validate_presence_of(:ticker) }
end
