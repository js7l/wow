class Session < ApplicationRecord
  belongs_to :studio
  has_many :bookings, dependent: :destroy
  has_one_attached :photo

  validates :name, :category, :date, :time, :duration, :limit_attendees, :price, :instructor, presence: true
end
