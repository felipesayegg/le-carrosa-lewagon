class CarsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @cars = Car.all
    @cars = Car.search_by_mod_and_brand(params[:query]) if params[:query]
  end

  def show
    @car = Car.find(params[:id])
  end

  def new
    @car = Car.new
  end

  def create
    # @car = Car.new(car_params)
    # @car.user = current_user
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

  def destroy
    @car = current_user.cars.find(params[:id])
    @car.destroy
    redirect_to cars_path
  end

  def my_cars
    @cars = current_user.cars
  end

  private

  def car_params
    params.require(:car).permit(:year, :km, :brand, :mod, :description, :price, photos: [])
  end

end
