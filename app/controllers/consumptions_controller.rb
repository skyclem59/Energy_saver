class ConsumptionsController < ApplicationController

  def show
  #  instantané

    @graph_instant_solar = []
     Consumption.where("energy = 'solar'").last(10).each do |c|
      @graph_instant_solar << [c.stamp.strftime("%H:%M") , c.value]
    end

    @graph_instant_elec = []
    Consumption.where("energy = 'elec'").last(10).each do |c|
      @graph_instant_elec << [c.stamp.strftime("%H:%M") , c.value]
    end

    @graph_instant_gas = []
    Consumption.where("energy = 'gas'").last(70).each do |c|
      @graph_instant_gas << [c.stamp.strftime("%H:%M") , c.value]
    end

    @graph_instant_water = []
    Consumption.where("energy = 'water'").last(10).each do |c|
      @graph_instant_water << [c.stamp.strftime("%H:%M") , c.value]
    end

    #  day

    @graph_day_solar = Consumption.where("energy = 'solar' and stamp > '#{Time.now - 86000}'")
    @graph_day_elec = Consumption.where("energy = 'elec' and stamp > '#{Time.now - 86000}'")
    @graph_day_gas = Consumption.where("energy = 'gas' and stamp > '#{Time.now - 86000}'")
    @graph_day_water = Consumption.where("energy = 'water' and stamp > '#{Time.now - 86000}'")

    #  week

    @graph_week_solar = Consumption.where("energy = 'solar' and stamp > '#{Time.now - 7.days}'")
    @graph_week_elec = Consumption.where("energy = 'elec' and stamp > '#{Time.now - 7.days}'")
    @graph_week_gas = Consumption.where("energy = 'gas' and stamp > '#{Time.now - 7.days}'")
    @graph_week_water = Consumption.where("energy = 'water' and stamp > '#{Time.now - 7.days}'")

    #  week

    @graph_month_solar = Consumption.where("energy = 'solar' and stamp > '#{Time.now - 1.months}'")
    @graph_month_elec = Consumption.where("energy = 'elec' and stamp > '#{Time.now - 1.months}'")
    @graph_month_gas = Consumption.where("energy = 'gas' and stamp > '#{Time.now - 1.months}'")
    @graph_month_water = Consumption.where("energy = 'water' and stamp > '#{Time.now - 1.months}'")


    #  year

    @graph_year_solar = Consumption.where("energy = 'solar' and stamp > '#{Time.now - 12.months}'")
    @graph_year_elec = Consumption.where("energy = 'elec' and stamp > '#{Time.now - 12.months}'")
    @graph_year_gas = Consumption.where("energy = 'gas' and stamp > '#{Time.now - 12.months}'")
    @graph_year_water = Consumption.where("energy = 'water' and stamp > '#{Time.now - 12.months}'")

    if params[:id] == "consumption_path(day)"
      @period = "d"
    elsif  params[:id] == "consumption_path(week)"
      @period = "w"
    elsif  params[:id] == "consumption_path(month)"
      @period = "m"
    else
      @period = "y"
    end
  end
end
