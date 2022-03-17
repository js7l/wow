class MessagesController < ApplicationController
  def create
    @chatroom = Chatroom.find(params[:chatroom_id])
    @message = Message.new(message_params)
    @message.chatroom = @chatroom
    @message.user = current_user
    other_person = @chatroom.other_person(current_user)
    if @message.save
      ChatroomChannel.broadcast_to(
        @chatroom,
        render_to_string(partial: "message", locals: {message: @message})
      )
      NotificationChannel.broadcast_to(
        other_person,
        {
          unread_count: current_user.unread_messages,
          chatroom_id: @chatroom.id,
          unread_chatroom_count: @chatroom.messages.where(user: current_user, read: false).count,
          message_content: @message.content
        }
      )
      head :ok
    else
      render "chatrooms/show"
    end
  end

  private

  def message_params
    params.require(:message).permit(:content, :chatroom_id, :user_id)
  end
end
