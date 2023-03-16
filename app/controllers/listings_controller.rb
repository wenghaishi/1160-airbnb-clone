class ListingsController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @listings = policy_scope(Listing.geocoded)
    @markers = @listings.map do |listing|
      {
        lat: listing.latitude,
        lng: listing.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: { listing: listing }),
        marker_html: render_to_string(partial: "marker")
      }
    end
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
    @listing = Listing.new
    authorize @listing
    render layout: 'new'
  end

  def create
    @listing = Listing.new(listing_params)
    @listing.owner = current_user
    authorize @listing
    if @listing.save
      redirect_to listings_path
      # redirect_to @listing
    else
      redirect_to new_listing_path
    end
  end

  def destroy
    @listing = Listing.find(params[:id])
    authorize @listing
    @listing.destroy
    redirect_to listings_path, status: :see_other
  end

  private

  def listing_params
    params.require(:listing).permit(:name, :description, :address, :photo, :price)
  end

end
