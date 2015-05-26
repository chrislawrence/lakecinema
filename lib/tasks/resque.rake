require "resque/tasks"

task "resque:setup" => :environment do
  ENV['QUEUE'] = '*'
end

desc "Alias for resque:work"
task "jobs:work" => "resque:work"
