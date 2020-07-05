class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  def after_sign_out_path_for(resource)
  	root_path
  end
  def after_sign_in_path_for(resource)
     user_path(resource)
  end
  def configure_permitted_parameters
     devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :postal_code, :prefecture_code, :address_city, :address_street, :password, :password_confirmation) }
     devise_parameter_sanitizer.permit(:sign_in) { |u| u.permit(:name, :password, :password_confirmation) }
  end
end
