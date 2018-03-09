class ConsumptionsController < ApplicationController

  def show



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

end

end
