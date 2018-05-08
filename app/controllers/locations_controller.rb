class LocationsController < ApplicationController
  def index
    @customer = Customer.find(params[:customer_id])
    @locations = @customer.locations.all
  end
end
