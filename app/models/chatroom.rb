class Chatroom < ApplicationRecord
  has_many :messages, dependent: :destroy
  belongs_to :user
  belongs_to :studio

<<<<<<< HEAD
  def other_person(current_user)
    if current_user == studio
      user
    else
      studio
    end
  end
=======
  # def other_person(current_user)
  #   if current_user == studio
  #     user
  #   else
  #     studio
  #   end
  # end
>>>>>>> ca746f69bd7a1a116da2caa97f7fee14a26624ad
end
