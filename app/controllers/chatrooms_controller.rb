class ChatroomsController < ApplicationController
  def show
    @chatroom = Chatroom.find(params[:id])
    @message = Message.new
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
