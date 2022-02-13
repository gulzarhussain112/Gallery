class ApplicationController < ActionController::Base
  
    add_flash_types :success, :warning, :danger, :info
    before_action :configure_permitted_parameters, if: :devise_controller?

  
    protected
  
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [ :name])
      devise_parameter_sanitizer.permit(:account_update, keys: [ :name])
    end

    def authenticate_admin!
      authenticate_user!
      redirect_to :home, status: :forbidden unless current_user.admin?
    end
end
