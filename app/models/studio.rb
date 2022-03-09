class Studio < ApplicationRecord
  belongs_to :user
  has_many :events, dependent: :destroy
  has_one_attached :avatar

  validates :address, :name, :email, :phone_number, :description, presence: true
  validates :user, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
end
