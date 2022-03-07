class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :session

  validates :status, :total_price, :total_attendees, presense: true
end
