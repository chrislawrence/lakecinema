FactoryGirl.define do
 factory :movie do
   title 'The Godfather'
   tmdb_id '256'
   
   factory :movie_with_showings do
     after :create do |movie|
       create(:showing, position: 0, day: 'Fri', times: '5pm', movie: movie)
       create(:showing, position: 1, day: 'Sat', times: 'Noon and 5pm', movie: movie)
       create(:showing, position: 2, day: 'Sun', times: 'Noon and 5pm', movie: movie)
     end
   end
 end

end
