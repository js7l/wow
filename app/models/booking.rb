class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :event
  has_one :review
  monetize :amount_cents

  validates :status, :amount, presence: true
end
