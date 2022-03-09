class EventsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show ]

  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
    # @booking = Booking.new
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