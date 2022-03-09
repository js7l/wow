class BookingsController < ApplicationController

  def show
    @event = Event.find(params[:event_id])
    @bookings = Booking.find(params[:id])
  end

  def create
    @booking = Booking.new(booking_params)
    @event = Event.find(params[:event_id])
    @booking.user = current_user
    @booking.total_price = @item.price * (@booking.end_date - @booking.start_date).to_i
    @booking.status = "Pending"
    @booking.event = @event
    if @booking.save
      redirect_to dashboard_path
    else
      render "event/show"
    end
  end

  def edit

  end

  def update

  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end
