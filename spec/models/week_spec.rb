require 'spec_helper'

describe Week do
  it 'generates the title based on the start and end dates' do
    week = create(:week, title: nil)
    expect(week.title).to eq("Weekend 14th, 15th, 16th March 2014")
  end

  it 'generates the holiday partial path' do
    week = create(:week)
    create(:holiday, week_id: week.id)
    expect(week.to_partial_path).to eq('weeks/week_with_holidays')
  end

  it 'generates the movie partial path' do
    week = create(:week)
    create(:movie, week_id: week.id)
    expect(week.to_partial_path).to eq('weeks/week_with_movies')
  end

end
