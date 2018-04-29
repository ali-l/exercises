class ReservationsController < ApplicationController

before_filter :load_restaurant

def index
		@reservations = Reservation.all
	end

	def show
		@reservation = Reservation.find(params[:id])
	end

	def new
		@reservation = Reservation.new
	end

	def edit
		@reservation = Reservation.find(params[:id])
	end

	def create

		@reservation = @restaurant.reservations.build(reservation_params)
	
			if @reservation.save
				redirect_to restaurants_path, notice: 'Reservation booked successfully'
			else
				render 'restaurants/show'
			end

	end

	def update
		@reservation = Reservation.find(params[:id])

		if @reservation.update_attributes(reservation_params)
			redirect_to reservation_path(@reservation)
		else
			render :edit
		end
	end

	def destroy
		@reservation = Reservation.find(params[:id])
		@reservation.destroy
		redirect_to reservations_path
	end

	private
	def reservation_params
		params.require(:reservation).permit(:restaurant_id, :customer_id, :size, :time)
	end

  	def load_restaurant
  		@restaurant = Restaurant.find(params[:restaurant_id])
  	end

end

