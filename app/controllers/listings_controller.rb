class ListingsController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @listings = policy_scope(Listing)
  end

  def show
    skip_authorization
    @listing = Listing.find(params[:id])
    @booking = Booking.new

    @marker = [{ lat: @listing.latitude,
                 lng: @listing.longitude,
                 info_window_html: render_to_string(partial: "info_window", locals: { listing: @listing }),
                 marker_html: render_to_string(partial: "marker") }]
  end

  def new
    skip_authorization
    @listing = Listing.new
    render layout: 'new_listing'
  end

  def create
  end

  def destroy
    @listing = Listing.find(params[:id])
    authorize @listing
    @listing.destroy
    redirect_to listings_path, status: :see_other
  end
end
