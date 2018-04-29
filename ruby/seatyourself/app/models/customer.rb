class Customer < ActiveRecord::Base
has_many :reviews
has_many :reservations

validates :name, :email, :phone, presence: true
end
