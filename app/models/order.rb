class Order < ApplicationRecord
  belongs_to :customer
  has_one :vendor
  has_one :location

  attr_accessor :customer_id, :vendor_id, :location_id, :tracking, :delivered, :shipment_duration

  validates :vendor_id, :tracking, :delivered, :shipment_duration, presence: true
end
