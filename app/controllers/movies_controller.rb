class MoviesController < ApplicationController
  skip_before_filter :authorise
  def show
    @movie = Movie.find(params[:id])
    respond_to do |format|
      format.js
    end
  end
end
