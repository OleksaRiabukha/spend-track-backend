class UsersController < ApplicationController
  skip_before_action :authorized, only: %i[create] 

  def create
    user = User.new(user_params)

    if user.valid?
      user.save
      token = issue_token(user)
      render json: { user: user, jwt: token }, status: :ok
    else
      render json: { errors: user.errors }, status: :bad_request
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password)
  end
end
