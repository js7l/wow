class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @categories = Event::CATEGORIES
  end

  def dashboard
    @review = Review.new
    @bookings_of_user = Booking.where(user: current_user)
    @bookings_from_user = Booking.joins(:event).where(event: { user: current_user })
    @favorited_events = current_user.all_favorited
    @events = @bookings_of_user.map do |booking|
      booking.event
    end
    @events = @events.sort_by { |event| event.time }
    @studios = @events.map do |event|
      event.studio
    end
    @markers = @studios.map do |studio|
      {
        lat: studio.latitude,
        lng: studio.longitude,
        image_url: helpers.asset_url("wow-logo.png")
      }
    end

    if Event.joins(:bookings).where(bookings: {user: current_user}).empty?
      @owner_status = false
    else
      @owner_status = true
    end
  end
end
