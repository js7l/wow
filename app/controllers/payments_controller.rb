class PaymentsController < ApplicationController
  def new
    @booking = current_user.bookings.where(status: 'Pending').find(params[:booking_id])
  end
end
