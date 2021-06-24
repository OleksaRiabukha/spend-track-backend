class CategoriesController < ApplicationController

  def create
    category = Category.new(category_params)

    if category.valid?
      category.save
      render json: { category: category }, status: :ok
    else
      render json: { errors: category.errors }, status: :bad_request
    end
  end


  private

  def category_params
    params.require(:category).permit(:name)
  end
end
