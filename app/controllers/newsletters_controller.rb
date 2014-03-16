class NewslettersController < ApplicationController
  def new
  end

  def edit
    week = Week.find(params[:id])
    @newsletter = week.newsletter || week.build_newsletter
  end

  def create
    @newsletter = Newsletter.new(newsletter_params)
    if @newsletter.save
      redirect_to dashboard_path, notice: 'Newsletter sent to Mailchimp'
    else
      render action: edit
    end
  end

  private

  def newsletter_params
    params.require(:newsletter).permit(:week_id, :introduction, :body)
  end
end
