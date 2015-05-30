class StaticController < ApplicationController
  skip_before_filter :authorise

  def index
    @weeks = Week.all.includes(movies: :showings)

  end

  def about
  end

  def subscribe
  end

  def contact
  end
end
