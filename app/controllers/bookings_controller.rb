class BookingsController < ApplicationController
  before_action :set_listing, only: %i[new create]

  def show
    render layout: "bookings"
  end


  def new
    skip_authorization

    @booking = Booking.new
  end

  def create
    skip_authorization

    @booking = Booking.new(booking_params)
    @booking.listing = @listing
    if @booking.save
      redirect_to listing_booking_path(@booking)
    else
      render 'listings/show', status: :unprocessable_entity
    end
  end

  private

  def set_listing
    @listing = Listing.find(params[:listing_id])
  end

  def booking_params
    params.require(:booking).permit(:start_date, :total, :end_date)
  end
end
