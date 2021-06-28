class SpendingsController < ApplicationController
  before_action :find_spending, only: %i[show new update destroy]

  def create
    spending = Spending.new(spending_params)
    spending.user = current_user

    if spending.valid?
      spending.save
      render json: SpendingSerializer.new(spending), status: :ok
    else
      render json: ActiveRecordErrorsSerializer.new(spending), status: :bad_request
    end
  end

  def index
    spendings = Spending.where(user_id: current_user.id).order("#{sort_spendings}")
    total_value = Spending.where(user_id: current_user.id).pluck(:amount).sum

    render json: {spendings: SpendingSerializer.new(spendings), total_amount: total_value}, status: :ok
  end

  def show
    if @spending.valid?
      render json: SpendingSerializer.new(@spending), status: :ok
    else
      render json: ActiveRecordErrorsSerializer.new(@spending), status: :not_found

    end
  end

  def update
    if @spending.update(spending_params)
      render json: SpendingSerializer.new(@spending), status: :ok
    else
      render json: ActiveRecordErrorsSerializer.new(@spending), status: :bad_request
    end
  end

  def destroy
    if @spending.destroy
      head :no_content
    else
      render json: ActiveRecordErrorsSerializer.new(@spending), status: :not_found
    end
  end

  private

  def spending_params
    params.require(:spending).permit(:description, :amount, :category_id)
  end

  def find_spending
    begin
      @spending = Spending.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: {errors: "Spending with id #{params[:id]} not found"}, status: :not_found
    end
  end

  def sort_spendings
    sort = { sort_by: "created_at", sort_dir: "desc"}
    sort[:sort_by] = params[:sort_by].split(" ").first if params[:sort_by].present?
    sort[:sort_dir] = params[:sort_by].split(" ").last if params[:sort_by].present?
    sort.values.join(" ")
  end
end
