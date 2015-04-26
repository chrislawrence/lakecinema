class Chimp 
  require 'mailchimp'
  attr_accessor :title, :body, :send_time, :campaign_id, :sender
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
    @campaign_id
  end

  def create_campaign
    response = @sender.campaigns.create(
      'regular',
      {
        list_id: '36d417399b',
        template_id: '277625',
        subject: 'Lake Cinema Newsletter',
        title: @title,
        from_name: 'Lake Cinema',
        from_email: 'admin@lakecinema.net.au',
        generate_text: true
    },
    {
      sections: {std_content00: @body}
    })

    @campaign_id = response['id']
    schedule_campaign(false)
  end

  def update_campaign
    begin
    @sender.campaigns.update(@campaign_id,'content', {sections: {std_content00: @body}})
    rescue
      return
    end
    schedule_campaign(true)
  end

  def schedule_campaign(scheduled=false)
    @sender.campaigns.unschedule(@campaign_id) if scheduled
    @sender.campaigns.schedule(@campaign_id, @send_time.utc.strftime("%Y-%m-%d %H:%M:%S"))
    send_test
  end

  def send_test
    @sender.campaigns.send_test(@campaign_id, ['c@chrislawrence.co'], 'html')
  end
end
