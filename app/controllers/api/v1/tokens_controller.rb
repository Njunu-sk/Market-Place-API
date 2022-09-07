class Api::V1::TokensController < ApplicationController
  def create
    @user = User.find_by_email(user_params[:email])

    token = AuthenticateUser.new(user_params[:email], user_params[:password]).call

    render json: { token: token, email: @user.email }
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
