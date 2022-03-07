class NonWorkingDay < ApplicationRecord
  validates :date, presence: true, uniqueness: true
end
