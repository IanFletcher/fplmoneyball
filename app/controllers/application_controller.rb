class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
  	devise_parameter_sanitizer.for(:sign_up)  do |u| 
  		u.permit(:email, :password, :password_confirmation, :username, :favorateclub, :firstname, :surname, :country, teams_attributes: [:name])
  	end
    devise_parameter_sanitizer.for(:account_update)  do |u| 
      u.permit(:email, :password, :password_confirmation, :current_password, :username, :favorateclub, :firstname, :surname, :country, teams_attributes: [:id, :name])
    end
  end
  def after_sign_out_path_for(resource)
    '/sign_in'
  end
end
