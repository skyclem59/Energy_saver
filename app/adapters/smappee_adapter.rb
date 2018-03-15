class SmappeeAdapter
  attr_writer :device

  def initialize(client_id, client_secret, device = nil)
    @client_id     = client_id
    @client_secret = client_secret
    @http_client   = RestClient
    @api_url       = 'https://app1pub.smappee.net/dev/v1'
    @device        = device
  end

  def get_token(username, password)
    payload = {
      grant_type: :password,
      client_id: @client_id,
      client_secret: @client_secret,
      username: username,
      password: password
    }

    headers = { content_type: 'application/x-www-form-urlencoded' }

    res = @http_client.post("#{@api_url}/oauth2/token", payload, headers)
    JSON.parse(res)
  end

  def refresh_expired_token(refresh_token)
    payload = {
      grant_type: :refresh_token,
      client_id: @client_id,
      client_secret: @client_secret,
      refresh_token:refresh_token
    }

    headers = { content_type: 'application/x-www-form-urlencoded' }

    res = @http_client.post("#{@api_url}/oauth2/token", payload, headers)
    JSON.parse(res)
  end

  def fetch_elec(from = 10.days.ago.to_i*1000)
    res = fetch_consumptions(from)
    res.map do |consumption|
      {
        energy: 'elec',
        stamp: DateTime.strptime("#{consumption['timestamp'] / 1000}",'%s'),
        value: consumption['consumption'],
        alwayson: consumption['alwaysOn']
      }
    end
  end

  def fetch_solar(from = 10.days.ago.to_i*1000)
    res = fetch_consumptions(from)
    res.map do |consumption|
      {
        energy: 'solar',
        stamp: DateTime.strptime("#{consumption['timestamp'] / 1000}",'%s'),
        value: consumption['solar'],
        alwayson: consumption['alwaysOn']
      }
    end
  end

  private

  def fetch_consumptions(from)
    return [] unless @device.present?

    now = Time.now.to_time.to_i*1000
    sl_id = service_location_id

    headers = {
      content_type: 'application/json',
      authorization: "Bearer #{refresh_access_token}"
    }

    res = @http_client.get("#{@api_url}/servicelocation/#{sl_id}/consumption?aggregation=1&from=#{from}&to=#{now}", headers)
    JSON.parse(res.body)['consumptions']
  end

  def refresh_access_token
    refresh_expired_token(@device.refresh_token)['access_token']
  end

  def service_location_id
    headers = {
      content_type: 'application/json',
      authorization: "Bearer #{refresh_access_token}"
    }

    res = @http_client.get("#{@api_url}/servicelocation", headers)

    JSON.parse(res.body)['serviceLocations'][0]['serviceLocationId']
  end
end
