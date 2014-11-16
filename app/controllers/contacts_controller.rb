class ContactsController < ApplicationController
  skip_before_filter :authorise

  def new 
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)
    if @message.valid?
      @message.send_email
      redirect_to root_path, notice: 'Your message has been delivered. Thankyou.'
    else 
      flash[:alert] = "Please fill in all fields"
      render 'new'
    end
  end

  private

  def header_path
    @header_path = 'layouts/small_header'
  end
  
  def message_params
    params.require(:message).permit(:nature, :name, :email, :organisation, :body)
  end
end
