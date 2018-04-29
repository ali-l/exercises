class Reservation < ActiveRecord::Base
	belongs_to :restaurant
	belongs_to :customer

validate :availability
validates :size, :time, presence: true


private
def availability
	unless restaurant.available?(size, time)
		errors.add(:base,"The restaurant is fully booked for the time slot requested.")
	end
end

end
