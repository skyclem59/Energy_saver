class UpdateConsumptionsService

  def initialize(adapter)
    @adapter = adapter
  end

  def call(energy_type)
    consumptions = Consumption.where(energy: energy_type).order(created_at: :asc)
    if consumptions.count > 0
      last_timestamp = consumptions.last.stamp.to_i * 1000
      res = @adapter.send("fetch_#{energy_type}", last_timestamp + 1)
    else
      res = @adapter.send("fetch_#{energy_type}")
    end

    res.each do |consumption_values|
      Consumption.create!(consumption_values)
    end
  end

end
