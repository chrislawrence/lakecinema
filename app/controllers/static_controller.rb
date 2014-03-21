class StaticController < ApplicationController
  def index
    @weeks = Week.all
  end

  def about
    @header_path = 'layouts/small_header'
  end

  def subscribe
    @header_path = 'layouts/small_header'
  end
end
