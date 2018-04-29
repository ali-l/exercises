class Restaurant < ActiveRecord::Base
has_many :customers, through: :reservations
has_many :reservations
has_many :reviews

validates :name, :email, :phone, :location, :food_type, :capacity, presence: true

	def available?(size, time)
		reserved = reservations.where(:time => time).sum(:size)
		size <= (capacity-reserved)
	end



end
