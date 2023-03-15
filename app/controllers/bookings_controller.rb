class BookingsController < ApplicationController
  before_action :set_listing, only: %i[new create]

  def show
    render layout: "bookings"
  end


  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.listing = @listing
    if @booking.save
      redirect_to listing_booking_path(@booking)
    else
      render 'listing/show', status: :unprocessable_entity
  end


private

def set_listing
  @listing = Listing.find(params[:listing_id])
end

def booking_params
  params.require(:booking).permit(:total)
end
