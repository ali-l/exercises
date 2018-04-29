class Pledge < ActiveRecord::Base
	# validate :amount_not_nil
	validates :amount, presence: true
	belongs_to :backer, class_name: 'User'
	belongs_to :reward
	# belongs_to :project, through: :reward

	def project
		self.reward.project
	end

	# def amount_not_nil
	# 	if self.amount.nil?
	# 		errors.add :amount, "Cannot be empty"
	# 	end
	# end


end
