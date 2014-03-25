require 'spec_helper'

describe Week do
  it 'generates the title based on the start and end dates' do
    week = create(:week, title: nil)
    expect(week.title).to eq("Weekend 14th, 15th, 16th March 2014")
  end

  it 'generates the title for school holiday programme' do
    week = create(:week, title: nil, holiday: Holiday.new)
    expect(week.title).to eq("School Holiday Programme")
  end

  it 'generates the holiday partial path' do
    week = create(:week)
    create(:holiday, week_id: week.id)
    expect(week.nested_partial_path).to eq('weeks/week_with_holidays')
  end

  it 'generates the movie partial path' do
    week = create(:week)
    create(:movie, week_id: week.id)
    expect(week.nested_partial_path).to eq('weeks/week_with_movies')
  end

  it 'returns a new newsletter if does not exist' do
    week  = create(:week)
    expect(week.get_or_build_newsletter).to be_a(Newsletter)
  end

  it 'returns a string of movie titles' do
    week = create(:week_with_two_movies)
    expect(week.movie_titles).to eq('2001 & The Godfather')
  end

  it 'orders the movies by view index' do
    week = create(:week)
    create(:movie, view_index: 1, week: week)
    create(:movie, view_index: 0, week: week)
    expect(week.movies.first.view_index).to eq(0)
  end

  it 'destroys the movies when destroying the week' do
    week = create(:week_with_movies_and_showings)
    week.destroy
    expect(Movie.count).to eq(0)
  end

  it 'removes week where #end_date is yesterday' do
    create(:week, start_date: 2.days.ago, end_date: 1.day.ago)
    Week.remove_old_weeks
    expect(Week.count).to eq(0)
  end

  it 'removes week where #end_date is today' do
    create(:week, start_date: 1.day.ago, end_date: Date.today)
    Week.remove_old_weeks
    expect(Week.count).to eq(0)
  end

  it 'does not touch week where #end_date is in the future' do
    create(:week, start_date: Date.today, end_date: 1.day.from_now)
    Week.remove_old_weeks
    expect(Week.count).to eq(1)
  end


  it 'reminds to write the newsletter for the current week when not done' do
    create(:week)
    expect(AdminMailer).to receive(:newsletter_reminder)
    Week.remind_to_write_newsletter
  end

  it 'does not remind to write the newsletter if it exists' do
    week = create(:week)
    create(:newsletter, week_id: week.id)
    expect(AdminMailer).to_not receive(:newsletter_reminder)
    Week.remind_to_write_newsletter
  end

end
