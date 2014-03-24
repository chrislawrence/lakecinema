class NewslettersController < ApplicationController

  def edit
    week = Week.find(params[:id])
    @newsletter = week.get_or_build_newsletter
  end

  def update
    @newsletter = Newsletter.find(params[:id])
    if @newsletter.update(newsletter_params)
      @newsletter.send_to_mailchimp
      redirect_to dashboard_path, notice: 'Newsletter sent to Mailchimp'
    else
      render action: edit
    end
  end

  private

  def newsletter_params
    params.require(:newsletter).permit(:introduction)
  end
end
