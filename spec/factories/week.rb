FactoryGirl.define do
 factory :week do
   start_date "2014-03-14"
   end_date "2014-03-16" 
   title "Weekend 14th, 15th, 16th March 2014"

   factory :week_with_movies_and_showings do
     after :create do |week|
       create(:movie_with_showings, week: week)
     end
   end

   factory :week_with_two_movies do
     after :create do |week|
       create(:movie, title: '2001', week: week)
       create(:movie, week: week)
     end
    end
  end
end
