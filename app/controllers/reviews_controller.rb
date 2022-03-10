class ReviewsController < ApplicationController

  def create
    @booking = Booking.find(params[:booking_id])
    @review = Review.new(review_params)
    @review.booking = @booking
    if @review.save
      redirect_to event_path(@booking.event)
    else
      render 'bookings/show'
    end
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating)
  end
end
