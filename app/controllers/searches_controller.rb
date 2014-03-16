class SearchesController < ApplicationController
  def index
    render json: Search.by_title(params[:term])
  end

  def show
    render json: Search.movie_by_id(params[:id])
  end
end
