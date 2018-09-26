class Api::V1::RolesController < Api::BaseController
  before_action :load_role, except: %i(index create)

  def index
    if @current_user.role == 0
      roles = Role.select :id, :name
      render json: {
        status: 200,
        error: false,
        message: "",
        data: roles,
        total_pages: 0
      }, status: 200
    else
      render json: {
        status: 500,
        error: true,
        message: "Bạn không có quyền",
        data: nil
      }, status: 500
    end
  end

  def create
    role = Role.new role_params

    if role.save
      render json: {
        status: 200,
        error: false,
        message: "",
        data: role.load_structure
      }, status: 200
    else
      render json: {
        status: 500,
        error: true,
        message: role.errors.full_messages.to_sentence,
        data: nil
      }, status: 500
    end
  end

  def update
    if @role.update_attributes role_params
      render json: {
        status: 200,
        error: false,
        message: "success",
        data: @role.load_structure,
      }, status: 200
    else
      render json: {
        status: 500,
        error: true,
        message: @role.errors.full_messages.to_sentence,
        data: nil
      }, status: 500
    end
  end

  def destroy
    if @role.destroy
      render json: {
        status: 200,
        error: false,
        message: "success",
        data: nil
      }, status: 200
    else
      render json: {
        status: 500,
        error: true,
        message: "fail",
        data: nil
      }, status: 500
    end
  end

  private
  def load_role
    @role = Role.find_by id: params[:id]

    return if @role
    render json: {
      status: 404,
      error: true,
      message: "role not exist",
      data: nil
    }, status: 404
  end

  def role_params
    params.require(:role).permit :name
  end
end
