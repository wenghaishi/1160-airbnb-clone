class ListingsController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @listings = policy_scope(Listing)

    if params[:query].present?
      sql_query = "name ILIKE :query OR address ILIKE :query OR description ILIKE :query"
      @listings = Listing.where(sql_query, query: "%#{params[:query]}%")
      @markers = @listings.map do |listing|
        {
          lat: listing.latitude,
          lng: listing.longitude,
          info_window_html: render_to_string(partial: "info_window", locals: { listing: listing }),
          marker_html: render_to_string(partial: "marker")
        }
      end
    else
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
    render layout: 'new_listing'
  end

  def create
    @listing = Listing.new(listing_params)
    @listing.owner = current_user
    authorize @listing

    if @listing.save
      redirect_to user_path(current_user)
      # redirect_to @listing
    else
      raise
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
