class FavoriteStock < ApplicationRecord
  belongs_to :user
  belongs_to :stock

  validates :stock, uniqueness: { scope: :user }
end
