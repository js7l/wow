class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :bookings, dependent: :destroy
  has_many :studios, dependent: :destroy
  has_many :chatrooms, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_one_attached :avatar
  acts_as_favoritor

  validates :first_name, :last_name, presence: true
  validates :first_name, uniqueness: { scope: :last_name }

  def chatroom
    @client_chatrooms = current_user.chatrooms # As a client
    @studio_chatrooms = Chatroom.where(studio: current_user.studios) # As a studio owner
    @chatrooms = (@client_chatrooms + @studio_chatrooms).uniq
  end

  def unread_messages
    Message.joins(:chatroom).where(read: false, chatrooms: { user: self }).or(Message.joins(:chatroom).where(read: false, chatrooms: { user: self })).count
  end
end
