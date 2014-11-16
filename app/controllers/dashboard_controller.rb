class DashboardController < ApplicationController
  layout 'admin'
  def index
    @weeks = Week.all
  end
end
