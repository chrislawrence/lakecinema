require 'spec_helper'

describe NewslettersController, type: :controller do
  before :each do
    expect_any_instance_of(ApplicationController).to receive(:authorise).and_return(true)
  end

  it 'get newsletter that exists' do
    week = create(:week)
    newsletter = create(:newsletter, week_id: week.id)
    get :edit, id: week.id
    expect(response.status).to eq(200)
  end
end

