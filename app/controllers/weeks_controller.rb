class WeeksController < ApplicationController
  def new
    @week = Week.new
    2.times do
      @week.movies.build
    end
  end

  def show
    @week = Week.find(params[:id])
  end

  def create
    @week = Week.new(week_params)
    if @week.save
      redirect_to week_path(@week)
    else
      render action: 'new'
    end
  end

  private

  def week_params
    params.require(:week).permit(:title, :start_date, :end_date, :movies_attributes => [:title, :rating, :overview, :poster_url])
  end
end
