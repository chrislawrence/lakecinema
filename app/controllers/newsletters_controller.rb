class NewslettersController < ApplicationController
  
  def index
    @newsletters = Newsletter.all
  end

  def new
    @newsletter = Newsletter.new
  end

  def create
    @newsletter = Newsletter.new(newsletter_params)
    if @newsletter.save
      @newsletter.send_to_mailchimp
      redirect_to admin_path, notice: 'Newsletter sent to Mailchimp'
    else
      render action: new
    end
  end

  def edit
    @newsletter = Newsletter.find(params[:id])
  end

  def update
    @newsletter = Newsletter.find(params[:id])
    if @newsletter.update(newsletter_params)
      @newsletter.send_to_mailchimp
      redirect_to admin_path, notice: 'Newsletter sent to Mailchimp'
    else
      render action: edit
    end
  end

  def destroy
    Newsletter.destroy(params[:id])
    flash[:notice] = 'Newsletter deleted'
    redirect_to admin_path

  end

  def show
    @newsletter = Newsletter.find(params[:id])
  end

  private

  def newsletter_params
    params.require(:newsletter).permit(:body, :send_date, :start_date, :end_date, movies_attributes: [:id, :tmdb_id, :title, :extra, :rating, :overview, :poster_url, :poster, :view_index, :cast, :director, showings_attributes: [:id, :day, :times, :position, :_destroy]])
  end
  
end
