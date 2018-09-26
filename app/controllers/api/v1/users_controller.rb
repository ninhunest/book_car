class Api::V1::UsersController < Api::BaseController

  def index
    users = User.all

    render json: {
        status: 200,
        error: false,
        message: "",
        data: users,
        total_pages: 0
      }, status: 200
  end
end
