class AddGoalToProject < ActiveRecord::Migration
  def change
  	add_column(:projects, :goal, :integer)
  end
end
