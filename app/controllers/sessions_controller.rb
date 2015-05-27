class SessionsController < ApplicationController
  skip_before_filter :authorise
  layout :false

  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      cookies.permanent[:token] = user.token
      redirect_to admin_path
      flash[:notice] = "Logged in"
    else
      flash[:alert] = "Email or password were invalid"
      render 'new'
    end
  end
  
  def destroy
    cookies.delete :token
    redirect_to root_path
    flash[:notice] = "Logged out"
  end
end
