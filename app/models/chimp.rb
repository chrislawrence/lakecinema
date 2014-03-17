class Chimp 
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
    self.schedule_campaign
    @campaign_id
  end

  def create_campaign
    @campaign_id = @sender.campaign_create(
      type: 'regular',
      options: {
        list_id: '36d417399b',
        template_id: '277625',
        subject: 'Lake Cinema Newsletter',
        title: @title,
        from_name: 'Lake Cinema',
        from_email: 'admin@lakecinema.net.au',
        generate_text: true
    },
    content: {
      html_std_content00: @body
    })
  end

  def update_campaign
    @sender.update_campaign(
      cid: @campaign_id,
      name: 'content',
      value: {
      html_std_content00: @body
    })
  end

  def schedule_campaign
    @sender.campaign_schedule(
      cid: @campaign_id,
      schedule_time: @send_time.strftime("%Y-%m-%d %H:%M:%S")
    )
    send_test
  end

  def send_test
    @sender.campaign_send_test(
      cid: @campign_id,
      test_emails: ['c@chrislawrence.co'],
      format: 'html'
    )
  end
end
