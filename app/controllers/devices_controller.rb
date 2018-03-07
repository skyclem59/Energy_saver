class DevicesController < ApplicationController
  def index
    before_action :set_device, only: [show:, :edit, :update, :destroy]

 #  list only the devices of the house vs current user

 @devices = Devices.where(house_id: current_user.house.id)

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
  redirect_to devices_path(@horse)
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

  def set_device
    @horse = Device.find(params[:id])
  end

  def device_params
    params.require(:device).permit(:name, :type_id, :house_id)
  end
end

