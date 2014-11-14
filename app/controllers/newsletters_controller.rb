class NewslettersController < ApplicationController
  layout 'newsletter'

  def edit
    week = Week.find(params[:id])
    @newsletter = week.get_or_build_newsletter
  end

  def update
    @newsletter = Newsletter.find(params[:id])
    if @newsletter.update(newsletter_params)
      send_to_mailchimp @newsletter
      redirect_to dashboard_path, notice: 'Newsletter sent to Mailchimp'
    else
      render action: edit
    end
  end

  def show
    @newsletter = Week.find(params[:id]).newsletter
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
    params.require(:newsletter).permit(:introduction)
  end
  
end
