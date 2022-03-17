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

    if params[:level].present?
      @events = @events.where(level: params[:level])
    end

    if params[:start_date].present?
      @events = @events.where('date > ?', params[:start_date])
    end

    @events = @events.where('start_time > ?', DateTime.now)

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

    respond_to do |format|
      format.html # Follow regular flow of Rails
      format.text { render partial: 'class_view', locals: { events: @events, events_group: @events_group }, formats: [:html] }
    end
  end

  def show
    @event = Event.find(params[:id])
    @studio = @event.studio
    @events = Event.where(studio: @studio)
    reviews = @studio.events.map {|event| event.reviews }
    @reviews = reviews.flatten
    @events_group = @events.group_by { |event| [event.date, event.time.strftime('%k:%M')] }
    @markers = [{
      lat: @studio.latitude,
      lng: @studio.longitude,
      info_window: render_to_string(partial: "events/info_window", locals: { studio: @studio }, formats: [:html]),
      image_url: helpers.asset_url("wow-logo.png")
    }] # marker for the current studio
    @chatroom = Chatroom.find_by(user: current_user, studio: @studio)
    if @chatroom.nil?
      @chatroom = Chatroom.new
      @chatroom.studio = @studio
      @chatroom.user = current_user
      @chatroom.save
    end
    @message = Message.new # input form
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.studio = current_user.studios.first
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
