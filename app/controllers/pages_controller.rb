class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @categories = Event::CATEGORIES
  end

  def dashboard
    @bookings_of_user = Booking.where(user: current_user)
    @bookings_from_user = Booking.joins(:event).where(event: { user: current_user })
    @favorited_events = current_user.all_favorited
    if Event.joins(:bookings).where(bookings: {user: current_user}).empty?
      @owner_status = false
    else
      @owner_status = true
    end
  end
end
