class StaticController < ApplicationController
  def index
    @weeks = Week.all
  end

  def about
  end

  def subscribe
  end
end
