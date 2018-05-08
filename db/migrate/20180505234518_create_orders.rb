class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.references :customer, index: true
      t.references :vendor
      t.references :location, index: true

      t.string :tracking
      t.boolean :delivered
      t.float :shipment_duration

      t.timestamps
    end
  end
end
