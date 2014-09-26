class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :set_page, if: :devise_controller?

  protected
  def set_page
    if request.referer.nil? || !request.referer.include?('users')
      session[:user_return_to] = request.referer
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:display_name, :email, :password, :password_confirmation, :remember_me) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:invite) { |u| u.permit(:email) }
    devise_parameter_sanitizer.for(:accept_invitation) { |u| u.permit(:display_name,  :password, :password_confirmation, :invitation_token) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:display_name, :email, :password, :password_confirmation, :current_password) }
  end
end
