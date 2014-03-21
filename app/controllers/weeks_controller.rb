class WeeksController < ApplicationController
  def new
    @week = Week.new
    2.times do
      movie = @week.movies.build
      %w[Fri Sat Sun].each_with_index do |w, i|
        movie.showings.build(day: w, view_index: i)
      end
    end
    @week.build_holiday
  end

  def edit
    @week = Week.find(params[:id])
  end

  def show
    @week = Week.find(params[:id])
  end

  def create
    @week = Week.new(week_params)
    if @week.save
      redirect_to week_path(@week)
    else
      flash[:alert] = 'There were errors'
      render action: 'new'
    end
  end

  def update
    @week = Week.find(params[:id])
    if @week.update(week_params)
      redirect_to week_path(@week)
    else
      flash[:alert] = 'There were errors'
      render action: 'edit'
    end
  end

  def destroy
    @week = Week.destroy(params[:id])
    redirect_to dashboard_url
  end

  private

  def week_params
    params.require(:week).permit(:title, :start_date, :end_date, movies_attributes: [:id, :title, :rating, :overview, :poster_url, showings_attributes: [:id, :day, :times, :view_index]], holiday_attributes: [:id, :preamble, :body])
  end
end
