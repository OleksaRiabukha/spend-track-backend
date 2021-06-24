class AuthenticationController < ApplicationController
  skip_before_action :authorized, only: %i[ create ]

  def create
    user = User.find_by(email: user_login_params[:email])
    if user && user.authenticate(user_login_params[:password])
      token = issue_token(user)
      render json: { user: user, jwt: token }
    else
      render json: { errors: "No such user. Try entering credentials again or signup" }, status: :unauthorized
    end
  end

  def show
    user = User.find_by(id: user_id)
    if logged_in?
      render json: user
    else
      render json: { errors: "No such user. Try entering credentials again or signup" }, status: :unauthorized
    end
  end

  private

  def user_login_params
    params.require(:user).permit(:email, :password)
  end
end
