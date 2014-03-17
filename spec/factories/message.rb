FactoryGirl.define do
 factory :message do
   email 'me@example.com'
   name 'Test'
   body 'This is an email'
   organisation 'Test'
   
   factory :invalid_message do
     email ''
   end
 end
end
