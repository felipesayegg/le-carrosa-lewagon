class CarsController < ApplicationController


  skip_before_action :authenticate_user!, only: :index

  def index
    @cars = Car.all
  end

  def show
    @car = Car.find(params(:id))
  end

  def new
    @car = Car.new
  end

  def create
    @car = current_user.cars.new(car_params)
    if @car.save
      redirect_to car_path(@car)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @car = current_user.cars.find(params[:id])
  end

  def update
    @car = current_user.cars.find(params[:id])
    if @car.update(car_params)
      redirect_to car_path(@car)
    else
      render :edit
    end
  end

  private

  def car_params
    params.require(:car).permit(:year, :brand, :mod, :description, :price, photos: [])
  end

end
