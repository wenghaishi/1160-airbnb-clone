class BookingsController < ApplicationController
  before_action :set_listing, only: %i[new show create]

  def show
    skip_authorization
    @booking = Booking.find(params[:id])
    @total_days = @booking.total / @listing.price
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
    @booking.user = current_user
    authorize @booking
    @total_days = (@booking.end_date.to_date - @booking.start_date.to_date).to_i
    @booking.total = @total_days * @listing.price
    if @booking.save
      redirect_to user_path(current_user)
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
