require 'spec_helper'

describe NewslettersController do
  before :each do
    ApplicationController.any_instance.stub(:authorise).and_return(true)
  end

  it 'get newsletter that exists' do
    week = create(:week)
    newsletter = create(:newsletter, week_id: week.id)
    get :edit, id: week.id
    expect(response.status).to eq(200)
  end
end

