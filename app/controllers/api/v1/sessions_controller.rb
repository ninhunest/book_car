class Api::V1::SessionsController < Api::BaseController
  skip_before_action :authenticate_user_from_token
  before_action :load_user_authentication, only: :create

  def create
    if @user.valid_password? user_params[:password]
      sign_in @user, store: false
      render json: {message: "Signed in successfully",
        user: @user, status: 200}
      return
    end
    invalid_login_attempt
  end

  def destroy
    user = User.find_by authentication_token: request.headers["Authorization"]
    unless user.nil?
      sign_out user
      render json: {message: "Signed out"}, status: 200
    else
      render json: {message: "Invalid token"}, status: 200
    end
  end

  private
  def user_params
    params.require(:user).permit :email, :password
  end

  def invalid_login_attempt
    render json: {message: "Sign in failed"}, status: 200
  end

  def load_user_authentication
    @user = User.find_by email: user_params[:email]

    return if @user && @user.valid_password?(user_params[:password])
    render json: {
      status: 400,
      error: true,
      message: "user khong ton tai",
      data: nil
    }, status: 400
  end
end
