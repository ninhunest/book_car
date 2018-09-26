class Api::V1::RegistrationsController < Api::BaseController
  skip_before_action :authenticate_user_from_token

  def create
    user = User.new user_params
    if user.save
      render json: {message: "Registration has been completed",user: user}, status: 200
    else
      warden.custom_failure!
      render json: {message: user.errors.messages, status: 200}
    end
  end

  private

  def user_params
    params.require(:user).permit :email, :name, :avata, :phone, :gender, :role,
                                 :birthday, :password, :password_confirmation
  end

  def load_user_authentication
    @user = User.find_by_email user_params[:email]
    return login_invalid unless @user
  end
end
