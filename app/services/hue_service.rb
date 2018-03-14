require 'rest-client'

clientid = ENV['HUE_CLIENT_ID']
clientsecret = ENV['HUE_CLIENT_SECRET']

class HueService

  def initialize(attributes)
    @device_id = attributes[:device_id]
  end

  def call
    url = "https://api.meethue.com/oauth2/auth?clientid=#{ENV['HUE_CLIENT_ID']}&deviceid=#{@device_id}&state=&response_type=code"
    puts RestClient.get(url)
  end

end
