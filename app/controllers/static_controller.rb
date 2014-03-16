class StaticController < ApplicationController
  def index
    @weeks = Week.all
  end
end
