class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    @cars = Car.all
    if params[:query]
      @cars = Car.search_by_mod_and_brand(params[:query])
    end

    # @cars = Car.search_by_mod_and_brand(params[:query]) if params[:query]
  end
end
