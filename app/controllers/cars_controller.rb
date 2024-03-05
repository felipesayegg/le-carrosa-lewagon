class CarsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @cars = Car.all
    @cars = Car.search_by_mod_and_brand(params[:query]) if params[:query]
  end

  def fipe_test
    @car = Car.new
  end

  def show
    @car = Car.find(params[:id])
  end

  def new
    @car = Car.new
  end

  def create
    @car = current_user.cars.new(car_params)

    brand_id = @car.brand
    mod_id = @car.mod
    year_id = @car.year

    base_url = "https://parallelum.com.br/fipe/api/v1/carros/marcas/"
    brand_data = URI.open(base_url).read
    brand = JSON.parse(brand_data)
    brand.each do |brand|
      if brand["codigo"] == brand_id
        @car.brand = brand["nome"]
      end
    end

    base_url = "https://parallelum.com.br/fipe/api/v1/carros/marcas/#{brand_id}/Modelos/"
    models_data = URI.open(base_url).read
    models = JSON.parse(models_data)
    models['modelos'].each do |model|
      if model["codigo"] == mod_id.to_i
        @car.mod = model["nome"]
      end
    end

    years_data = URI.open("https://parallelum.com.br/fipe/api/v1/carros/marcas/#{brand_id}/Modelos/#{mod_id}/Anos/").read
    years = JSON.parse(years_data)
    years.each do |year|
      if year["codigo"] == year_id
        @car.year = year["nome"].slice(0, 4)
        @car.url_fipe = "https://parallelum.com.br/fipe/api/v1/carros/marcas/#{brand_id}/Modelos/#{mod_id}/Anos/"
      end
    end

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

  def delete_photo
    @car = current_user.cars.find(params[:id])
    photo = @car.photos.find_by(id: params[:photo_id])
    photo.purge if photo.present?
    redirect_to edit_car_path(@car)
  end

  private

  def car_params
    params.require(:car).permit(:year, :km, :brand, :mod, :description, :price, photos: [])
  end
end
