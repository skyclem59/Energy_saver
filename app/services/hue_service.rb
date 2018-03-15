require 'rest-client'

clientid = ENV['HUE_CLIENT_ID']
clientsecret = ENV['HUE_CLIENT_SECRET']

class HueService

  def initialize(attributes)
    @device_id = attributes[:device_id]
  end

  def call
    url = "https://api.meethue.com/oauth2/auth?clientid=#{ENV['HUE_CLIENT_ID']}&deviceid=#{@device_id}&state=&response_type=code"

    GET https://api.meethue.com/oauth2/auth?clientid=jq5AQ0zHi5uwhKqzbviNfiG4WXAaqd4F&response_type=code&state=xUvdhs&appid=myappid&deviceid=mydeviceid&devicename=mydevicename
    puts RestClient.get(url)

    GET https://api.meethue.com/oauth2/auth?clientid=<5WesmfWpogqScdAMP0sTgUU0GHwB68lE>&response_type=code&state=xUvdhs&appid=energysaver&deviceid=mydeviceid&devicename=energysaver


  end

end GET https://api.meethue.com/oauth2/auth?clientid=5WesmfWpogqScdAMP0sTgUU0GHwB68lE&response_type=code&state=xUvdhs&appid=energysaver&deviceid=001788fffe6279d7&devicename=energysaver




# @client_id =   "5WesmfWpogqScdAMP0sTgUU0GHwB68lE"
# @secret_id =   "nrsoYzyeDsc6aOK4"
# @app = "energysaver"
# @device_id = "001788fffe6279d7"
# @username": "Jd7BRYz6h3GQlQxVdyxS4nqSGnow2hjydVFAAsYc"

# http://<http://10.10.105.176>/api/Jd7BRYz6h3GQlQxVdyxS4nqSGnow2hjydVFAAsYc/lights/1/state


  @code = params[:code]
  require ‘rest-client’
  payload = {
    grant_type: ‘authorization_code’,
    client_id: ENV[‘NEST_ID’],
    client_secret: ENV[‘NEST_SECRET’],
    code: params[:code]
  }
  headers = { content_type: ‘application/x-www-form-urlencoded’ }
  res = RestClient.post(“https://api.home.nest.com/oauth2/access_token“, payload, headers)
  response = JSON.parse(res.to_s)
  response[“access_token”]
  headers = {
    authorization: “Bearer #{response[‘access_token’]}“,
    content_type: ‘application/json’
  }

  res = RestClient.get(“https://developer-api.nest.com/devices/cameras”, headers)
  p ‘?’ * 200
  @devices = JSON.parse(res.to_s)
end


def hue_bulbs


end

def huecallback



  @client_id =   "5WesmfWpogqScdAMP0sTgUU0GHwB68lE"
  @secret_id =   "nrsoYzyeDsc6aOK4"
  @app = "energysaver"
  @device_id = "001788fffe6279d7"
  @username = "Jd7BRYz6h3GQlQxVdyxS4nqSGnow2hjydVFAAsYc"
  url_auth = 'https://api.meethue.com/oauth2/auth?'

   # authentification


   headers = { content_type: url_auth}
   res = RestClient.get("https://api.meethue.com/oauth2/auth?clientid=5WesmfWpogqScdAMP0sTgUU0GHwB68lE&response_type=code&state=xUvdhs&appid=energysaver&deviceid=001788fffe6279d7&devicename=energysaver")
   response = JSON.parse(res.to_s)
   p response
   response[“code”]
   headers = {
   }
 end


# route


get 'hue/callback', to: 'hue#callback'


