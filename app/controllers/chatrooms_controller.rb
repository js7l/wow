class ChatroomsController < ApplicationController
  def index
    @client_chatrooms = current_user.chatrooms # As a client
    @studio_chatrooms = Chatroom.where(studio: current_user.studios) # As a studio owner
    @chatrooms = (@client_chatrooms + @studio_chatrooms).uniq
  end

  def show
    @chatroom = Chatroom.find(params[:id])
    @message = Message.new
    # other_person = @chatroom.other_person(current_user)
    # @messages = @chatroom.messages.where(user: other_person)
    # @messages.update_all(read: true)
    @unread = @chatroom.messages.select { |m| m.user != current_user && m.read == false }
    @unread.each do |msg|
      msg.read = true
      msg.save!
    end
  end

  def create
    @chatroom = Chatroom.new
    @studio = Studio.find(params[:studio_id])
    @chatroom.studio = @studio
    @chatroom.user = current_user
    if @chatroom.save
      redirect_to studio_path(@studio)
    end
  end
end
