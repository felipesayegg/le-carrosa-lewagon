class OrdersController < ApplicationController
  def index
    @orders = current_user.orders
  end

  def show
    @order = Order.find(params[:id])
  end

  def new
    @car = Car.find(params[:car_id])
    @order = Order.new
  end

  def create
    @car = Car.find(params[:car_id])
    @order = Order.new
    @order.car = @car
    @order.user = current_user
    @car.selled = true
    @car.save

    if @order.save
      redirect_to order_path(@order)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:order).permit(:date)
  end
end
