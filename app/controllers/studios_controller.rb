class StudiosController < ApplicationController
  def show
    @studio = Studio.find(params[:id])
    @events = Event.where(studio: @studio)
    @events_group = @events.group_by { |event| [event.date, event.time.strftime('%k:%M')] }.sort_by { |group| group[0] }
    @chatroom = Chatroom.find_by(user: current_user, studio: @studio)
    @message = Message.new # input form
    @markers = [{
        lat: @studio.latitude,
        lng: @studio.longitude,
        info_window: render_to_string(partial: "events/info_window", locals: { studio: @studio }, formats: [:html]),
        image_url: helpers.asset_url("wow-logo.png")
      }] # marker for the current studio
  end

  def new
    @studio = Studio.new
  end

  def create
    @studio = Studio.new(studio_params)
    @studio.user = current_user
    if @studio.save
      redirect_to studio_path(@studio)
    else
     render 'new'
    end
  end

  private

  def studio_params
    params.require(:studio).permit(:name, :address, :email, :phone_number, :description, :avatar)
  end
end
