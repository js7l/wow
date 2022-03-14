class Review < ApplicationRecord
  belongs_to :booking
  validates :rating, presence: true
  validates :content, length: { minimum: 20 }
end
