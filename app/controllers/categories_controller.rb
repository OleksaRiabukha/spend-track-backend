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
    render json: CategorySerializer.new(@category), status: :ok
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def find_category
    begin
      @category = Category.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: {errors: "Category with id #{params[:id]} not found"}, status: :not_found
    end
  end
end
