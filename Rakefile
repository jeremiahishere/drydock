require "bundler/gem_tasks"
require 'drydock'

task :test do
  template = ENV['TEMPLATE'] || "./dockerfile.temlpate.erb"
  destination = ENV['DESTINATION'] || "./docker_project"
  runner = Drydock::Launcher::TestRun.new(template, destination)
  runner.run
end
