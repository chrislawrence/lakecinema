require 'spec_helper'

describe ProgrammeEditor do
  it 'makes a newsletter with a new week' do
    week = create(:week_with_movies_and_showings)
    ProgrammeEditor.new(week)
    expect(Newsletter.last.week).to eq(week)
  end 
end
