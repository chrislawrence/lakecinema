desc "Remove old weeks from programme"

task :remove_old_weeks => :environment do
  puts "Removing old weeks"
  Week.remove_old_weeks
end
