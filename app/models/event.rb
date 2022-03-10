class Event < ApplicationRecord
  CATEGORIES = ["Yoga", "Surfing", "HIIT", "Boxing", "Weight Lifting", "Crossfit", "Swimming", "Others"]
  LEVELS = ["Beginner", "Intermediate", "Advanced", "All Levels"]
  belongs_to :studio
  has_many :bookings, dependent: :destroy
  has_one_attached :photo
  acts_as_favoritable

  validates :name, :category, :date, :time, :duration, :limit_attendees, :price, :instructor, :level, presence: true
  validates :category, inclusion: { in: CATEGORIES }
  validates :level, inclusion: { in: LEVELS }

  include PgSearch::Model
  pg_search_scope :search_by,
    against: [ :name, :category],
    associated_against: {
      studio: [ :name, :address ]
    },
    using: {
      tsearch: { prefix: true } # <-- now `superman batm` will return something!
    }

end
