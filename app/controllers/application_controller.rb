class ApplicationController < ActionController::Base
    before_action :authenticate_user!

#    protect_from_forgery with: :null_session
    protect_from_forgery with: :exception
    before_action :configure_permitted_parameters, if: :devise_controller?



#     skip_before_action :verify_authenticity_token
#+    before_action :authenticate_user!
#+    before_action :configure_permitted_parameters, if: :devise_controller?
  

    protected
  
      def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password])
        devise_parameter_sanitizer.permit(:account_update, keys: [:email, :password, :current_password, :rundeck_token, :netbox_token, :proxmox_user, :proxmox_password, :mmonit_username, :mmonit_password])
      end
    
      
end
