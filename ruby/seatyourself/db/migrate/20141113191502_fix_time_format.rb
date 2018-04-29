class FixTimeFormat < ActiveRecord::Migration
  def change
  	remove_column :restaurants, :time_open
  	remove_column :restaurants, :time_closed
  	add_column :restaurants, :time_open, :datetime
  	
  end
end
