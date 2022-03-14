class StudiosController < ApplicationController
  def show
    @studio = Studio.find(params[:id])
    @events = Event.where(studio: @studio)
    @events_group = @events.group_by { |event| [event.date, event.time.strftime('%k:%M')] }
    @chatroom = Chatroom.find_by(user: current_user, studio: @studio)
    @message = Message.new # input form
  end
end
