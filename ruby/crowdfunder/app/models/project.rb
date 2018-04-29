class Project < ActiveRecord::Base
	belongs_to :owner, class_name: 'User'
	has_many :backers, through: :pledges, class_name: 'User'
	has_many :rewards
	has_many :pledges, through: :rewards
	
	accepts_nested_attributes_for :rewards, reject_if: :all_blank, allow_destroy: true
	
	def amount_raised
		self.pledges.sum(:amount)
	end

	def match_reward(amount)
		rewards.where(['amount <= ?', amount]).order('amount desc').first
	end

	def days_left
		"#{((self.end_date.getlocal - Time.now.getlocal)/86400).truncate} D, #{(((self.end_date.getlocal - Time.now.getlocal)/86400).modulo(1)*24).round} H"
	end

	def backed_by_user?(current_user)
		backers.include?(current_user)
	end

	def select_reward_tier(reward_amount)
		rewards.where('amount <= ?', reward_amount).order('amount asc').last
	end

end
