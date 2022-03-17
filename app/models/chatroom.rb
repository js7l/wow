class Chatroom < ApplicationRecord
  has_many :messages, dependent: :destroy
  belongs_to :user
  belongs_to :studio

  def other_person(current_user)
    if current_user == studio
      user
    else
      studio
    end
  end
end
