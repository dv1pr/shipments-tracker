require 'pp'

class Locations::OrdersController < ApplicationController
  before_action :set_customer_and_location

  def index
    @orders = {}
    @customer.orders.where(location_id: params[:location_id]).each do |o|
      if !@orders[o[:vendor_id]]
        @orders[o[:vendor_id]] = {}
        @orders[o[:vendor_id]][:vendor_name] = ""
        @orders[o[:vendor_id]][:avg_delivery] = 0.0
        @orders[o[:vendor_id]][:orders] = {}
      end

      name = Vendor.find(o[:vendor_id]).name
      @orders[o[:vendor_id]][:vendor_name] = name
      @orders[o[:vendor_id]][:orders][o[:id]] = { shipment_duration: o[:shipment_duration], tracking: o[:tracking] }
    end

    @orders.each do |key, val|
      val[:orders].each do |k, v|
        val[:avg_delivery] += v[:shipment_duration]
      end
      val[:avg_delivery] = (val[:avg_delivery] /val[:orders].count).round(2)
    end

    @locations = @customer.locations.all
  end

  def new
    @order = Order.new
  end

  def create
    order = @customer.orders.new
    order.customer_id = @customer.id
    order.vendor_id = params[:order][:vendor_id]
    order.location_id = @location.id
    order.tracking = params[:order][:tracking]
    order.shipment_duration = params[:order][:shipment_duration]
    order.delivered = params[:order][:delivered]
    if order.save
      redirect_to new_customer_location_order_path, notice: "Order saved!"
    else
      redirect_to new_customer_location_order_path, alert: "There was some trouble saving your order"
    end
    order.save!
  end

  def show
    @order = @customer.orders.find(params[:id])
  end

  private

    def set_customer_and_location
      @customer = Customer.find(params[:customer_id])
      @location = @customer.locations.find(params[:location_id])
    end
end
