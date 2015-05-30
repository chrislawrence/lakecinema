require 'spec_helper'

describe Mailchimp do
  it 'gets the current list of subscribers' do
    Mailchimp.get_subscribers
  end
end
