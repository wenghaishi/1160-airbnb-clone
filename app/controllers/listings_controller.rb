class ListingsController < ApplicationController
  skip_before_action :authenticate_user!
  def index
    @listings = policy_scope(Listing)
  end

  def show
    skip_authorization
    @listing = Listing.find(params[:id])
  end

  def new
    render layout: 'new_listing'
  end

  def create
  end

  def destroy
    authorize @listing

    @listing = Listing.find(params[:id])
    @listing.destroy
    redirect_to listings_path, status: :see_other
  end
end
