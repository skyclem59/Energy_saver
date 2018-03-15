class DevicesController < ApplicationController
  before_action :set_device, only: [:show, :edit, :update, :destroy]

  def index
    @graph_instant_gas = Consumption.where("energy = 'gas'").last(10).map do |c|
      [c.stamp.strftime("%H:%M") , c.value]
    end

    @graph_instant_water = Consumption.where("energy = 'water'").last(10).map do |c|
      [c.stamp.strftime("%H:%M") , c.value]
    end

    @graph_instant_solar = Consumption.where("energy = 'solar'").last(10).map do |c|
      [c.stamp.strftime("%H:%M") , c.value]
    end

    @graph_instant_elec = Consumption.where("energy = 'elec'").last(10).map do |c|
      [c.stamp.strftime("%H:%M") , c.value]
    end

    # @smappee = Device.find_by_name("Smappee");
    #
    # service = service_location(@smappee.token)
    # consumptions = get_consumption(@smappee.token, service['serviceLocations'][0]['serviceLocationId'])
    # consumptions = consumptions['consumptions']
    # @graph_instant_solar = consumptions.map do |consumption|
    #   timestamp = consumption['timestamp']/1000
    #   date = DateTime.strptime(timestamp.to_s,'%s').strftime("%H:%M")
    #   p "^"*100
    #   p timestamp
    #   p date
    #   [date, consumption['solar']]
    # end
    #
    # @graph_instant_elec = consumptions.map do |consumption|
    #   timestamp = consumption['timestamp']/1000
    #   date = DateTime.strptime(timestamp.to_s,'%s').strftime("%H:%M")
    # [date, consumption['consumption']]
    # end
    #
    # @graph_instant_gas = []
    # Consumption.where("energy = 'gas'").last(10).each do |c|
    #   @graph_instant_gas << [c.stamp.strftime("%H:%M") , c.value]
    # end
    #
    # @graph_instant_water = []
    # Consumption.where("energy = 'water'").last(10).each do |c|
    #   @graph_instant_water << [c.stamp.strftime("%H:%M") , c.value]
    # end
    #
    # #  list only the devices of the house vs current user
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

  def service_location(token)
    begin
      headers = {
        content_type: 'application/json',
        authorization: "Bearer #{token}"
      }

      res = RestClient.get("https://app1pub.smappee.net/dev/v1/servicelocation", headers)
      p '!'*100
      JSON.parse(res.to_s)
    rescue => e
        p '!'*100
        p e
    end

  end

  def get_consumption(token, id)
    now = Time.now.to_time.to_i*1000
    headers = {
      content_type: 'application/json',
      authorization: "Bearer #{token}"
    }

    res = RestClient.get("https://app1pub.smappee.net/dev/v1/servicelocation/#{id.to_s}/consumption?aggregation=2&from=1520590013000&to=#{now}", headers)
    JSON.parse(res.to_s)
  end
end
