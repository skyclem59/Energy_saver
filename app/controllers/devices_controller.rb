class DevicesController < ApplicationController
  before_action :set_device, only: [:show, :edit, :update, :destroy]

  def index

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
      if @device.type.brand_id == 3
        redirect_to "https://home.nest.com/login/oauth2?client_id=#{ENV['NEST_ID']}&state=STATE&redirect_uri=#{nest_callback_url}"
      else
        redirect_to devices_path
      end
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

  def nestcallback
    @code = params[:code]
    require 'rest-client'
    payload = {
      grant_type: 'authorization_code',
      client_id: ENV['NEST_ID'],
      client_secret: ENV['NEST_SECRET'],
      code: params[:code]
    }
    headers = { content_type: 'application/x-www-form-urlencoded' }
    res = RestClient.post("https://api.home.nest.com/oauth2/access_token", payload, headers)
    response = JSON.parse(res.to_s)
    response["access_token"]
    headers = {
      authorization: "Bearer #{response['access_token']}",
      content_type: 'application/json'
    }

    res = RestClient.get("https://developer-api.nest.com/devices/cameras", headers)
    p '?' * 200
    @devices = JSON.parse(res.to_s)
  end

  private

  def set_device
    @device = Device.find(params[:id])
  end

  def device_params
    params.require(:device).permit(:name, :type_id, :house_id)
  end
end
