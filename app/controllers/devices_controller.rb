class DevicesController < ApplicationController
  before_action :set_device, only: [:show, :edit, :update, :destroy]


  def index

    redirect_to edit_house_path(current_user.house.id)  unless Device.all.count > 0

    @graph_instant_solar = []
    Consumption.where("energy = 'solar'").last(10).each do |c|
      @graph_instant_solar << [c.stamp.strftime("%H:%M") , c.value]
    end

    @graph_instant_elec = []
    Consumption.where("energy = 'elec'").last(10).each do |c|
      @graph_instant_elec << [c.stamp.strftime("%H:%M") , c.value]
    end

    @graph_instant_gas = []
    Consumption.where("energy = 'gas'").last(10).each do |c|
      @graph_instant_gas << [c.stamp.strftime("%H:%M") , c.value]
    end

    @graph_instant_water = []
    Consumption.where("energy = 'water'").last(10).each do |c|
      @graph_instant_water << [c.stamp.strftime("%H:%M") , c.value]
    end

    #  list only the devices of the house vs current user
    @devices = Device.where(house: current_user.house)
    @light_devices = Device.where(house: current_user.house, type: Type.where(name: 'Lampes').first)
    @thermostat = Device.where(house: current_user.house, type: Type.where(name: 'Thermostat').first).first
    @camera = Device.where(house: current_user.house, type: Type.where(name: 'Camera').first).first
  end

  def show
  end

  def new
    @device = Device.new
  end

  def create
    @device = Device.new(device_params)
    @device[:house_id]= current_user.house.id
    if @device.save
      redirect_to devices_path
    end
  end

  def edit
  end

  def update
    @device.update(device_params)
    redirect_to devices_path
  end

  def destroy
    @device.destroy
    redirect_to devices_path
  end

  private

  def set_device
    @device = Device.find(params[:id])
  end

  def device_params
    params.require(:device).permit(:name, :type_id, :house_id)
  end

 end
