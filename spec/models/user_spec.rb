require 'spec_helper'

describe User do
  it 'generates a token on save' do
    user = create(:user)
    expect(user.token).to_not be_nil
  end
end
