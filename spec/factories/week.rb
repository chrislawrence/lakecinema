FactoryGirl.define do
 factory :week do
   start_date Date.today
   end_date  3.days.from.now
 end
end
