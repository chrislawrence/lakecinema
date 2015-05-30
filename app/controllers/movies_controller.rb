class MoviesController < ApplicationController
  def show
    @movie = Movie.find(params[:id])
    respond_to do |format|
      format.js
    end
  end
end
