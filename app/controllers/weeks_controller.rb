class WeeksController < ApplicationController
  def new
    @week = Week.new
    @week.movies.build
    
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
      ProgrammeEditor.new(@week)
      redirect_to week_path(@week)
    else
      flash[:alert] = 'There were errors'
      render action: 'new'
    end
  end

  def update
    @week = Week.find(params[:id])
    if @week.update(week_params)
      ProgrammeEditor.new(@week)
      redirect_to week_path(@week)
    else
      flash[:alert] = 'There were errors'
      render action: 'edit'
    end
  end

  def destroy
    @week = Week.destroy(params[:id])
    redirect_to admin_path
  end

  private

  def week_params
    params.require(:week).permit(:title, :start_date, :end_date, :category, :body, movies_attributes: [:id, :tmdb_id, :title, :extra, :after, :rating, :overview, :poster_url, :poster, :view_index, showings_attributes: [:id, :day, :times, :view_index]], holiday_attributes: [:id, :preamble, :body])
  end
end
