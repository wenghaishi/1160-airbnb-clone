class ListingsController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @listings = policy_scope(Listing)
  end

  def show
    skip_authorization
    @listing = Listing.find(params[:id])
    @booking = Booking.new
  end

  def new
    skip_authorization
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
