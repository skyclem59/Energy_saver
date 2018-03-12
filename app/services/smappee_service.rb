# require 'oauth2'

# client = OAuth2::Client.new('SCAILTEUX René', 'Pepsie59$', :site => 'https://app1pub.smappee.net/dev/v1/oauth2/token')

# token = client.auth_code.authorize_url(:redirect_uri => 'http://localhost:3000/oauth2/callback')


# p token
# # response = token.get('https://app1pub.smappee.net/dev/v1/oauth2/token')


require 'rest-client'

url = 'https://app1pub.smappee.net/dev/v1/oauth2/token'

response = RestClient.post(url, { client_id: 'SCAILTEUX René', client_secret: 'Pepsie59$'}, headers={})

p response

# TODO
