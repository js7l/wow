class BookingsController < ApplicationController

  def show
    @booking = Booking.find(params[:id])
    @review = Review.new
  end

  def create
    @booking = Booking.new
    @event = Event.find(params[:event_id])
    @booking.user = current_user
    @booking.amount = @event.price
    @booking.status = "Pending"
    @booking.event = @event
    if @booking.save
      # redirect_to dashboard_path
      session = Stripe::Checkout::Session.create(
        payment_method_types: ['card'],
        line_items: [{
          name: @event.name,
          images: [@event.photo.service_url],
          amount: @event.price_cents,
          currency: 'usd',
          quantity: 1
        }],
        success_url: dashboard_url,
        cancel_url: dashboard_url
      )
      @booking.update(checkout_session_id: session.id)
      redirect_to new_booking_payment_path(@booking)
    else
      render "events/show"
    end
  end

  def update
    @booking = Booking.find(params[:id])
    @booking.status = params[:booking][:status]
    if @booking.save
      redirect_to dashboard_path
    end
  end


end
