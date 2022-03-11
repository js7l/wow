class Event < ApplicationRecord
  CATEGORIES = ["Yoga", "Surfing", "HIIT", "Boxing", "Weight Lifting", "Crossfit", "Swimming", "Others"]
  LEVELS = ["Beginner", "Intermediate", "Advanced", "All Levels"]

  before_save :add_start_time_end_time_after_creation

  belongs_to :studio
  has_many :bookings, dependent: :destroy
  has_many :reviews, through: :bookings
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

  private

  def add_start_time_end_time_after_creation
    d = self.date
    t = self.time
    self.start_time = DateTime.new(d.year, d.month, d.day, t.hour, t.min, t.sec, t.zone)
    self.end_time = self.start_time + self.duration.minutes
  end

end
