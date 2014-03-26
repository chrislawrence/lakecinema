class StaticController < ApplicationController
  skip_before_filter :authorise

  def index
    @weeks = Week.all.includes(movies: :showings)

  end

  def about
    @header_path = 'layouts/small_header'
  end

  def subscribe
    @header_path = 'layouts/small_header'
  end
end
