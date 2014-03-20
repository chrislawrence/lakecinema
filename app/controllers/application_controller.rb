class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :header_path

  def header_path
    if request.subdomain == 'admin'
      @header_path = 'layouts/admin_header'
    else
      @header_path = 'layouts/header'
    end
  end
end
