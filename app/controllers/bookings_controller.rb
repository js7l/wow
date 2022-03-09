class BookingsController < ApplicationController

  def create
    @booking = Booking.new
    @event = Event.find(params[:event_id])
    @booking.user = current_user
    @booking.total_price = @event.price
    @booking.status = "Confirmed"
    @booking.event = @event
    if @booking.save
      redirect_to dashboard_path
    else
      render "events/show"
    end
  end

  def edit

  end

  def update

  end


end
