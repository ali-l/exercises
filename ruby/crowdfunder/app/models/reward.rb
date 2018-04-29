class Reward < ActiveRecord::Base
	belongs_to :project
	has_many :pledges
	#belongs_to :backer, through: :pledges, class_name: "User"
end
