class Message 
  include ActiveModel::Model
  NATURES = ['General Inquiry', 'Organisations and Schools', 'Website Issue']
  attr_accessor :name, :email, :body, :nature, :organisation
  validates :email, presence: true

  def send_email
    if self.nature == 'Organisations and Schools'
      ContactMailer.cinema(self).deliver
    else
      ContactMailer.website(self).deliver
    end
  end
end
