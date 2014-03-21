class SessionsController < ApplicationController
  skip_before_filter :authorise

  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      cookies.permanent[:token] = user.token
      redirect_to dashboard_url
    else
      flash[:alert] = "Email or password were invalid"
      render 'new'
    end
  end
end
