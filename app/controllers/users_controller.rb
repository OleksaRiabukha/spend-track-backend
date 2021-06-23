class UsersController < ApplicationController
  
  def create
    user = User.new(user_params)

    if user.save
      render json: user, status: :ok
    else
      render json: { errors: user.errors }, status: :bad_request
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password_digest)
  end
end
