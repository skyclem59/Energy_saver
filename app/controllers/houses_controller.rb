class HousesController < ApplicationController
  before_action :set_house, only: [:show, :edit, :update]

  def show
  end

  def new
  @house = House.new
  end

  def create
    @house = house.new(house_params)
    if @house.save
      redirect_to house_path(@house)
    else
      render :new
    end
  end

  def edit
  end

  def update
    @house.update(house_params)
        # redirect_to houses_path
  end

  def house_params
    params.require(:house).permit(:name)
  end

  def set_house
    @house = House.find(params[:id])
  end

end
