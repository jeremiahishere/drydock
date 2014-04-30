require "bundler/gem_tasks"
require 'workers_with_preconditions'

task :test do
  runner = WorkersWithPreconditions::Launcher::TestRun.new
  runner.run
end
