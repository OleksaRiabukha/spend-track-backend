class SpendingsController < ApplicationController
  before_action :find_spending, only: %i[show update destroy]

  def create
    spending = Spending.new(spending_params)
    spending.user = current_user
    spending.category = Category.find_by(id: spending_params[:category_id])

    if spending.valid?
      spending.save
      render json: { spending: spending }, status: :ok
    else
      render json: { errors: spending.errors }, status: :bad_request
    end
  end

  def index
    spendings = Spending.all
    render json: { spendings: spendings }, status: :ok
  end

  def show
    if @spending.valid?
      render json: { spending: @spending }, status: :ok
    else
      render json: { errors: @spending.errors }, status: :bad_request
    end
  end

  def update
    if @spending.valid?
      @spending.update(spending_params)
      render json: { spending: @spending }, status: :ok
    else
      render json: { errors: @spending.errors }, status: :bad_request
    end
  end

  def destroy
    if @spending.destroy
      head :no_content
    else
      render json: { errors: @spending.errors }, status: :bad_request
    end
  end

  private

  def spending_params
    params.require(:spending).permit(:description, :amount, :category_id)
  end

  def find_spending
    @spending = Spending.find(params[:id])
  end
end
