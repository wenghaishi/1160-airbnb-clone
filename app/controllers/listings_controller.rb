class ListingsController < ApplicationController
  skip_before_action :authenticate_user!
  def index
    @listings = Listing.all
  end

  def new
    render layout: 'new_listing'
  end

  def create
  end
end
