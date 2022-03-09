class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validates :status, :total_price, :total_attendees, presence: true
end
