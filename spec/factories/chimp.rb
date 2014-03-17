FactoryGirl.define do
 factory :chimp do
   title '2014-03-17'
   send_time Time.now + 1.day
   message 'Newsletter of the week'
 end
end
