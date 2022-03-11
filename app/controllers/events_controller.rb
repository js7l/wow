require 'date'

class EventsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show ]

  def index
    @categories = Event::CATEGORIES

    if params[:query].present?
      @events = Event.search_by(params[:query]).order(:date, :time)
    elsif params[:category].present?
      @events = Event.where(category: params[:category]).order(:date, :time)
    else
      @events = Event.order(:date, :time)
    end

    if params[:date].present?
      @events = @events.where(date: params[:date])
    end

    if params[:time].present?
      @events = @events.where(time: params[:time])
    end

    @events_group = @events.group_by { |event| [event.date, event.time.strftime('%k:%M')] }
    @studios = Studio.where(id: @events.pluck(:studio_id))
    # the `geocoded` scope filters only studios with coordinates (latitude & longitude)
    @markers = @studios.geocoded.map do |studio|
      {
        lat: studio.latitude,
        lng: studio.longitude,
        info_window: render_to_string(partial: "info_window", locals: { studio: studio }, formats: [:html]),
        image_url: helpers.asset_url("wow-logo.png")
      }
    end

    #simple calender gem
    start_date = params.fetch(:start_date, Date.today).to_date
    @meetings = Event.where(start_time: start_date.beginning_of_week..(start_date.end_of_week + 1.day))

    respond_to do |format|
      format.html # Follow regular flow of Rails
      format.text { render partial: 'class_lists', locals: { events: @events, events_group: @events_group }, formats: [:html] }
    end
  end

  def show
    @event = Event.find(params[:id])
    # @studio = Studio.find(params[:event_id])
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

  def favourite
    @event = Event.find(params[:event_id])
    current_user.favorite(@event)
    flash[:notice] = "Added to favourite"
    redirect_to event_path(@event)
  end

  def unfavourite
    @event = Event.find(params[:event_id])
    current_user.unfavorite(@event)
    flash[:notice] = "Removed from favorite"
    redirect_to event_path(@event)
  end


  private

  def event_params
    params.require(:event).permit(:name, :category, :date, :time, :duration, :limit_attendees,
      :price, :instructor, :level, :photo)
  end
end
