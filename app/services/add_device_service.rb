class AddDeviceService

  def initialize(adapter)
    @adapter = adapter
  end

  def call(username, password, house)
    tokens = @adapter.get_token(username, password)

    Device.create!(
      name: 'Smappee',
      type: Type.find_by(name: 'Smappee'),
      house: house,
      token: tokens['access_token'],
      refresh_token: tokens['refresh_token'],
      expires_in: tokens['expires_in']
    )
  end
end
