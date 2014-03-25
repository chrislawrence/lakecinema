set :output, '/home/chris/apps/lakecinema/current/log/cron.log'

every 1.day, :at => '9:10 pm' do
  command "cd /home/chris/apps/lakecinema/current && rails r -e production 'Week.remove_old_weeks'"
end

every :wednesday, :at => '12:00 pm' do
  command "cd /home/chris/apps/lakecinema/current && rails r -e production 'Newsletter.remind_to_write'"
end
