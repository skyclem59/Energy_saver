# require 'oauth2'

# client = OAuth2::Client.new('SCAILTEUX René', 'Pepsie59$', :site => 'https://app1pub.smappee.net/dev/v1/oauth2/token')

# token = client.auth_code.authorize_url(:redirect_uri => 'http://localhost:3000/oauth2/callback')


# p token
# # response = token.get('https://app1pub.smappee.net/dev/v1/oauth2/token')


require 'rest-client'

url = 'https://api.meethue.com/oauth2/auth'

response = RestClient.get("https://api.meethue.com/oauth2/auth?clientid=<clientid>&deviceid=<deviceid>&state=<state>&response_type=code")

p response

clientid = 'lF5rG097tvAonj82ifAzcNMXb60MYohg'

clientsecret = 'ldZQbph5mPWQRAg4'

clientid = 'lF5rG097tvAonj82ifAzcNMXb60MYohg'
appid = '?'
deviceid = "001788fffe277a9e"
devicename = '?'
state="?"

url = "https://api.meethue.com/oauth2/auth?clientid=#{clientid}&appid=#{appid}&deviceid=#{deviceid}&devicename=#{devicename}&state=#{state}&response_type=code"


"https://api.meethue.com/oauth2/auth?clientid=lF5rG097tvAonj82ifAzcNMXb60MYohg&deviceid=001788fffe277a9e&response_type=code"
