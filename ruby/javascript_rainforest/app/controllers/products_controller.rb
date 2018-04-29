class ProductsController < ApplicationController
	def index
		@products = if params[:search] 
			Product.where("LOWER(name) LIKE LOWER(?)", "%#{params[:search]}%").page(params[:page])
		else
			Product.all.page(params[:page])
		end


		# When search is made, typed = true
		@typed = params.delete(:typed)
		
		respond_to do |format|
      format.html
      format.js
    end
	end

	def show
		@product = Product.find(params[:id])

		if current_user
			@review = @product.reviews.build
		end
	end

	def new
		@product = Product.new
	end

	def edit
		@product = Product.find(params[:id])
	end

	def create
		@product = Product.new (product_params)

		if @product.save
			redirect_to products_path
		else
			render :new
		end
	end

	def update
		@product = Product.find(params[:id])

		if @product.update_attributes(product_params)
			redirect_to product_path(@product)
		else
			render :edit
		end
	end

	def destroy
		@product = Product.find(params[:id])
		@product.destroy
		redirect_to products_path
	end

	private
	def product_params
		params.require(:product).permit(:name, :description, :price_in_cents)
	end
end
