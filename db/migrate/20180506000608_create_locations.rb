class CreateLocations < ActiveRecord::Migration[5.1]
  def change
    create_table :locations do |t|
      t.references :customer, index: true

      t.string :name
      t.float :latitude
      t.float :longitude
      t.string :address_1
      t.string :address_2
      t.string :city
      t.string :state
      t.string :zip

      t.timestamps
    end
  end
end
