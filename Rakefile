require "bundler/gem_tasks"
require 'drydock'

task :run do
  template = ENV['TEMPLATE'] || "./dockerfile.template.erb"
  destination = ENV['DESTINATION'] || "./docker_project"
  runner = Drydock::Launcher::TestRun.new(template, destination)
  runner.run
end
