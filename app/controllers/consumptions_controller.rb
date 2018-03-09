class ConsumptionsController < ApplicationController

  def show
    @consumptions = Consumption.all
  end

end
