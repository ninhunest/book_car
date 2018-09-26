class Api::BaseController < ActionController::API
  acts_as_token_authentication_handler_for User, {fallback: :none}

  private
  def current_user
    @current_user ||= User.find_by authentication_token: request.headers["Authorization"]
  end

  def authenticate_user_from_token
    render json: {message: "You are not authenticated"},
      status: 401 if current_user.nil?
  end

  def login_invalid
    render json:
      {message: "Invalid login"}, status: 200
  end
end
