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
    @newsletter = Week.find(params[:id]).newsletter
  end

  def update
    @newsletter = Newsletter.find(params[:id])
    if @newsletter.update(newsletter_params)
      send_to_mailchimp @newsletter
      redirect_to admin_path, notice: 'Newsletter sent to Mailchimp'
    else
      render action: edit
    end
  end

  def show
    @newsletter = Newsletter.find(params[:id])
  end

  def send_to_mailchimp newsletter
    campaign_id = Chimp.new(
      title: newsletter.id, 
      body: render_to_string('newsletters/show', newsletter: newsletter),
      campaign_id: newsletter.campaign_id, 
      send_time: newsletter.send_time
    ).send
    newsletter.update(:campaign_id, campaign_id)
  end

  private

  def newsletter_params
    params.require(:newsletter).permit(:body, :send_date, :start_date, :end_date, :movie_attributes => [:title, :rating, :overview, :cast, :director, :poster_url, :poster])
  end
  
end
