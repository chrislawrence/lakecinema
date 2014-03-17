class Chimp 
  attr_accessor :subject, :body, :send_time, :campaign_id, :sender
  API_KEY = APP_CONFIG['mailchimp_key']

  def initialize attributes={}
    attributes.each do |key, value|
      if self.respond_to?(key.to_sym)
        self.instance_variable_set("@#{key}", value)
      end
    end
    @sender = Mailchimp::API.new(API_KEY)
  end

  def send 
    if !@campaign_id 
      self.create_campaign
    else
      self.update_campaign
    end
  end

  def create_campaign
    1
  end

  def update_campaign
    1
  end


end
