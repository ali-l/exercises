class FixTimeFormat2 < ActiveRecord::Migration
  def change
  	  	add_column :restaurants, :time_closed, :datetime
  end
end
