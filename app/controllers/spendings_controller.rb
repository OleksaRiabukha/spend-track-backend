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
    spendings = Spending.where(user_id: current_user.id).order("#{sort_spendings}")
    total_value = Spending.where(user_id: current_user.id).pluck(:amount).sum

    render json: { spendings: spendings, total: total_value }, status: :ok
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

  def sort_spendings
    sort = { sort_by: "created_at", sort_dir: "desc"}
    sort[:sort_by] = params[:sort_by] if params[:sort_by].present?
    sort[:sort_dir] = params[:sort_dir] if params[:sort_dir].present?
    sort.values.join(" ")
  end

end
