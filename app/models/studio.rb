class Studio < ApplicationRecord
  belongs_to :user
  has_many :sessions, dependent: :destroy

  validates :address, :name, :email, :phone_number, :description, presence: true
  validates :user, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
end
