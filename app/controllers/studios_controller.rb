class StudiosController < ApplicationController
  def show
    @studio = Studio.find(params[:id])
    @events = Event.where(studio: @studio)
    @events_group = @events.group_by { |event| [event.date, event.time.strftime('%k:%M')] }
    @chatroom = Chatroom.find_by(user: current_user, studio: @studio)
    @message = Message.new # input form
    @markers = [{
        lat: @studio.latitude,
        lng: @studio.longitude,
        info_window: render_to_string(partial: "events/info_window", locals: { studio: @studio }, formats: [:html]),
        image_url: helpers.asset_url("wow-logo.png")
      }] # marker for the current studio
  end
end
