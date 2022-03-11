class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :event
  has_one :review

  validates :status, :total_price, presence: true
end
