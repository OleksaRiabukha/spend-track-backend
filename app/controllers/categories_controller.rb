class CategoriesController < ApplicationController
  before_action :find_category, only: %i[ show ]

  def create
    category = Category.new(category_params)

    if category.valid?
      category.save
      render json: CategorySerializer.new(category), status: :ok
    else
      render json: ActiveRecordErrorsSerializer.new(category), status: :bad_request
    end
  end

  def index 
    categories = Category.all

    render json: CategorySerializer.new(categories), status: :ok
  end

  def show
    if @category.valid?
      render json: CategorySerializer.new(@category), status: :ok
    else
      render json: ActiveRecordErrorsSerializer.new(@category), status: :bad_request
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def find_category
    @category = Category.find(params[:id])
  end
end
