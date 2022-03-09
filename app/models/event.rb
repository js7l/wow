class Event < ApplicationRecord
  CATEGORIES = ["Yoga", "Surfing", "HIIT", "Boxing", "Weight Lifting", "Crossfit", "Swimming", "Others"]
  LEVELS = ["Beginner", "Intermediate", "Advanced", "All Levels"]
  belongs_to :studio
  has_many :bookings, dependent: :destroy
  has_one_attached :photo

  validates :name, :category, :date, :time, :duration, :limit_attendees, :price, :instructor, :level, presence: true
  validates :category, inclusion: { in: CATEGORIES }
  validates :level, inclusion: { in: LEVELS }
end
