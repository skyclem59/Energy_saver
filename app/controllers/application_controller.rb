class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  skip_before_action :authenticate_user!, only: :home

  def configure_permitted_parameters
  # For additional in app/views/devise/registrations/edit.html.erb
  devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :avatar])
  end
end

#  test branch pk
