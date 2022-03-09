class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validates :status, :total_price, presence: true
end
