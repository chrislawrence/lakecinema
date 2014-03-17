FactoryGirl.define do
 factory :newsletter do
   introduction "Welcome to the newsletter"
   send_time 1.day.from_now
 end
end
