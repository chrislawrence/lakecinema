class MessagesController < ApplicationController
  def new
    @header_path = 'layouts/small_header'
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)
    if @message.valid?
      @message.send_email
      redirect_to root_path, notice: 'Your message has been delivered. Thankyou.'
    else 
      render action: 'new', notice: 'Nope'
    end
  end
  private
  
  def message_params
    params.require(:message).permit(:nature, :name, :email, :organisation, :body)
  end
end
