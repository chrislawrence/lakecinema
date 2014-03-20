class Message 
  include ActiveModel::Model
  NATURES = ['General Inquiry', 'Organisations and Schools', 'Website Issue']
  CINEMA_EMAIL = 'boblakec@hotmail.com'
  WEBSITE_EMAIL = 'c@chrislawrence.co'

  attr_accessor :name, :email, :body, :nature, :organisation
  validates :email, presence: true
  validates :body, presence: true

  def send_email
    if self.nature == 'Organisations and Schools'
      ContactMailer.new_message(self, CINEMA_EMAIL).deliver
    else
      ContactMailer.new_message(self, WEBSITE_EMAIL).deliver
    end
  end
end
