class DashboardController < ApplicationController
  def index
    @weeks = Week.all
  end
end
