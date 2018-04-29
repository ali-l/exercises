class Review < ActiveRecord::Base
	belongs_to :customer
	belongs_to :restaurant

	validates :title, :body, presence: true
end
