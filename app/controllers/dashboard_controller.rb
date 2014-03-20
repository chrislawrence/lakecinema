class DashboardController < ApplicationController
  def index
    @header_path = 'layouts/admin_header'
    @weeks = Week.all
  end
end
