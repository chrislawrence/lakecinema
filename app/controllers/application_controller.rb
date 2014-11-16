class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :authorise

  def authorise
    current_user ||= User.find_by(token: cookies[:token])
    redirect_to login_url unless current_user
  end
end
