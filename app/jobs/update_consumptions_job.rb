class UpdateConsumptionsJob < ApplicationJob
  queue_as :default

  def perform(device_id)
    update_smappee_consumptions
  end

  private

  def update_smappee_consumptions
    return unless device = Device.find_by(name: 'Smappee')
    adapter = smappee_adapter
    adapter.device = device

    consumptions_service(adapter).call('elec')
    consumptions_service(adapter).call('solar')
  end

  def smappee_adapter
    SmappeeAdapter.new(ENV['SMAPPEE_CLIENT_ID'], ENV['SMAPPEE_CLIENT_SECRET'])
  end

  def consumptions_service(adapter)
    UpdateConsumptionsService.new(adapter)
  end
end
