class Studio < ApplicationRecord
  belongs_to :user
  has_many :sessions, dependent: :destroy

  validates :address, :name, :email, :phone_number, :description, presence: true
  validates :user, uniqueness: true
end
