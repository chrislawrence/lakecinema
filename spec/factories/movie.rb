FactoryGirl.define do
 factory :movie do
   title 'The Godfather'
   
   factory :movie_with_showings do
     after :create do |movie|
       create(:showing, view_index: 0, day: 'Fri', times: '5pm', movie: movie)
       create(:showing, view_index: 1, day: 'Sat', times: 'Noon and 5pm', movie: movie, view_index: 1)
       create(:showing, view_index: 2, day: 'Sun', times: 'Noon and 5pm', movie: movie, view_index: 2)
     end
   end
 end

end
