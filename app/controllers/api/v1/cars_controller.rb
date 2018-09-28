class Api::V1::CarsController < Api::BaseController
  before_action :load_car, except: %i(index create)

  def index
    cars = Car.select :id, :bien_so
    byebug
    render json: {
        status: 200,
        error: false,
        message: "",
        data: cars,
        total_pages: 0
      }, status: 200
  end

  def create
    car = Car.new car_params
    if car.save
      params[:car_photos]['photo'].each do |a|
        car_photo = car.car_photos.create!(anh: a)
      end
      render json: {
        status: 200,
        error: false,
        message: "",
        data: car.load_structure
      }, status: 200
    else
      render json: {
        status: 500,
        error: true,
        message: car.errors.full_messages.to_sentence,
        data: nil
      }, status: 500
    end
  end

  def update
    if @car.update_attributes car_params
      render json: {
        status: 200,
        error: false,
        message: "success",
        data: @car.load_structure,
      }, status: 200
    else
      render json: {
        status: 500,
        error: true,
        message: @car.errors.full_messages.to_sentence,
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
  def load_car
    @car = Car.find_by id: params[:id]

    return if @car
    render json: {
      status: 404,
      error: true,
      message: "car not exist",
      data: nil
    }, status: 404
  end

  def car_params
    params.require(:car).permit :bien_so, :so_cho, car_photos_attributes: [:id, :car_id, :anh]
  end
end
