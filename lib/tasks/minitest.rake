# Override the default task
task :default => [] # Just in case it hasn't already been set
Rake::Task[:default].clear
task :default => "minitest:all:quick"