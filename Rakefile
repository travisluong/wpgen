require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new('test')

task :build_gem do
  puts "building gem"
  system("gem build wpgen.gemspec && gem install wpgen")
end

task :default => [:build_gem, :test]
