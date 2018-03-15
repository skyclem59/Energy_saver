class SmappeeController < ApplicationController

  def new
    @model = Credentials.new
  end

  def create
    @model = Credentials.new(credential_params)

    adapter = SmappeeAdapter.new(ENV['SMAPPEE_CLIENT_ID'], ENV['SMAPPEE_CLIENT_SECRET'])

    begin
      device = AddDeviceService.new(adapter).call(@model.username, @model.password, house)
      adapter.device = device

      redirect_to edit_house_path(house)
    rescue RestClient::BadRequest => e
      flash.now[:alert] = "Nous n'avons pas pu ajouter votre objet. Veuillez vérifier vos informations."
      render :new
    end
  end

  private

  def house
    current_user.house
  end

  def credential_params
    params.require(:credentials).permit(:username, :password)
  end

end
