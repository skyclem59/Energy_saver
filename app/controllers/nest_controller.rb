require 'rest-client'

class NestController < ApplicationController
  def new
    @device = Device.new
  end

  def create
    token = get_token
    create_nest_device(current_user.house, token)
    redirect_to edit_house_path(0)
  end

  private

  def get_token
    code = params[:code]

    payload = {
      grant_type: 'authorization_code',
      client_id: ENV['NEST_ID'],
      client_secret: ENV['NEST_SECRET'],
      code: code
    }

    headers = { content_type: 'application/x-www-form-urlencoded' }
    res = RestClient.post("https://api.home.nest.com/oauth2/access_token", payload, headers)
    response = JSON.parse(res.to_s)
    response['access_token']
  end

  def create_nest_device(house, token)
    Device.create!(
      name: 'Nest',
      type: Type.find_by(name: 'Camera'),
      house: house,
      token: token
    )
  end
end
