require 'date'

class EventsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show ]

  def index
    @events = Event.order(:date)
    @events_group = @events.group_by { |event| [event.date, event.time.strftime('%I:%M %p')] }

    @studios = Studio.all
    # the `geocoded` scope filters only studios with coordinates (latitude & longitude)
    @markers = @studios.geocoded.map do |studio|
      {
        lat: studio.latitude,
        lng: studio.longitude,
        info_window: render_to_string(partial: "info_window", locals: { studio: studio }),
        image_url: helpers.asset_url("wow-logo.png")
      }
    end
  end

  def show
    @event = Event.find(params[:id])
    # @studio = Studio.new
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.user = current_user
    if @event.save
      redirect_to event_path(@event)
    else
      render :new
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    @event.update(params[:event])
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
  end

  private

  def event_params
    params.require(:event).permit(:name, :category, :date, :time, :duration, :limit_attendees,
      :price, :instructor, :level, :photo)
  end
end
