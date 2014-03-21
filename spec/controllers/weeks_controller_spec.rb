require 'spec_helper'

describe WeeksController do
  before :each do
    ApplicationController.any_instance.stub(:authorise).and_return(true)
  end

  it 'accepts nested film attributes' do
    post 'create', week: attributes_for(:week).merge(:movies_attributes=> [attributes_for(:movie)])
    expect(Week.first.movies.first.title).to eq(build(:movie).title)
  end
  
  it 'rejects movies if form not filled' do
    post 'create', week: attributes_for(:week)
    expect(Week.first.movies.count).to eq(0)
  end

end
