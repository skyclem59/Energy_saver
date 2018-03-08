class DevicesController < ApplicationController
  before_action :set_device, only: [:show, :edit, :update, :destroy]

  def index
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
