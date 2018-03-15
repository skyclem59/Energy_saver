class NestAdapter
  attr_writer :device

  def initialize(device = nil)
    # @client_id     = client_id
    # @client_secret = client_secret
    @http_client   = RestClient
    @api_url       = 'https://app1pub.smappee.net/dev/v1'
    @device        = device
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

  private

  def refresh_access_token
    refresh_expired_token(@device.refresh_token)['access_token']
  end
end
