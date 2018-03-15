class PhilipsController < ApplicationController

  def new
    @device = Device.new
  end

  def create
    @device = Device.new(device_params)
    @device[:house_id]= current_user.house.id
    @device[:type_id]= Type.find_by(name: 'Lampes').id

    if @device.save
      redirect_to edit_house_path(current_user.house)
    end

  end

  private

  def device_params
    params.require(:device).permit(:name, :type_id, :house_id)
  end

end

