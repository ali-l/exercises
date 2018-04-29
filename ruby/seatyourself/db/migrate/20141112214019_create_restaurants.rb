class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.string :location
      t.integer :price
      t.integer :time_open
      t.integer :time_closed
      t.string :food_type
      t.integer :capacity
      t.string :photo_url
      t.string :site_url

      t.timestamps
    end
  end
end
