class ReviewsController < ApplicationController
def index
		@reviews = Review.all
	end

	def show
		@review = Review.find(params[:id])
	end

	def new
		@review = Review.new
	end

	def edit
		@review = Review.find(params[:id])
	end

	def create
		@review = Review.new(review_params)

		if @review.save
			redirect_to review_path
		else
			render :new
		end
	end

	def update
		@review = Review.find(params[:id])

		if @review.update_attributes(review_params)
			redirect_to review_path(@review)
		else
			render :edit
		end
	end

	def destroy
		@review = Review.find(params[:id])
		@review.destroy
		redirect_to reviews_path
	end

	private
	def review_params
		params.require(:review).permit(:name, :email, :price, :location, :food_type, :capacity, :phone, :time_open, :time_closed)
	end

end