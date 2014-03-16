require 'spec_helper'

describe Week do
  it 'generates the title based on the start and end dates' do
    week = create(:week, title: nil)
    expect(week.title).to eq("Weekend 14th, 15th, 16th March 2014")
  end

end
