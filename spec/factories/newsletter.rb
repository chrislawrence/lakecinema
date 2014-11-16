FactoryGirl.define do
  factory :newsletter do
    introduction "Welcome to the newsletter"
    send_time 1.day.from_now
    start_date 2.days.from_now
    end_date 4.days.from_now
 end
end
